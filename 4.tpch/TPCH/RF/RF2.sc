#include <sqlcli.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/time.h>

FILE *fp; 

struct timeval m_beginTime;
struct timeval m_endTime;
int m_elapsedTime = 0;

EXEC SQL BEGIN DECLARE SECTION;
char  usr[10];
char  pwd[10];
int   port;
char  option[128];
long  key;
EXEC SQL END DECLARE SECTION;

int ElapsedTime(struct timeval *beginTime, struct timeval *endTime)
{
    struct timeval v_timeval;
    int elapsedTime;

    v_timeval.tv_sec  = endTime->tv_sec  - beginTime->tv_sec;
    v_timeval.tv_usec = endTime->tv_usec - beginTime->tv_usec;

    if (v_timeval.tv_usec < 0)
    {
        v_timeval.tv_sec -= 1;
        v_timeval.tv_usec = 999999 - v_timeval.tv_usec * (-1);
    }
    elapsedTime = v_timeval.tv_sec * 1000000 + v_timeval.tv_usec;
    return( elapsedTime );
}

void ExecDML()
{
    char line[128];
    while( 1 )
    {
        if( fgets(line, sizeof(line), fp) != NULL )
        {
            key = atol(line);

            printf( "%ld\n", key );

            EXEC SQL DELETE FROM ORDERS WHERE O_ORDERKEY = :key;
            if(sqlca.sqlcode != 0)
            {
                printf("Error : [%d] %s\n\n", SQLCODE, sqlca.sqlerrm.sqlerrmc);
                exit(-1);
            }
            EXEC SQL DELETE FROM LINEITEM WHERE L_ORDERKEY = :key;
            if(sqlca.sqlcode != 0)
            {
                printf("Error : [%d] %s\n\n", SQLCODE, sqlca.sqlerrm.sqlerrmc);
                exit(-1);
            }
        }
        else
        {
            break;
        }
    }
}	
   
void totalTime()
{
    double elapsedTime = 0.00;
    elapsedTime = (double)m_elapsedTime/1000000;
    printf("elapsed time : %.2f (sec)\n", elapsedTime);
}

void logon()
{
    strcpy(usr, "SYS");
    strcpy(pwd, "MANAGER");
    port = 20309;

    sprintf( option, "DSN=127.0.0.1;PORT_NO=%d", port );

    EXEC SQL CONNECT :usr IDENTIFIED BY :pwd USING :option;
    if (sqlca.sqlcode != SQL_SUCCESS)
    {
        printf("Error : [%d] %s\n\n", SQLCODE, sqlca.sqlerrm.sqlerrmc);
        exit(-1);
    }
}

void logout()
{
    EXEC SQL DISCONNECT;
    if(sqlca.sqlcode != SQL_SUCCESS)
    {
        printf("Error : [%d] %s\n\n", SQLCODE, sqlca.sqlerrm.sqlerrmc);
    }
}


int main(int argc, char **argv)
{
    if( argc != 2 )
    {
        printf( "usage: rf2 file\n" );
        exit(-1);
    }

    logon();

    fp = fopen( argv[1], "r" );

    if( fp == NULL )
    {
        printf( "fopen error: %s\n", argv[1] );
        exit(-1);
    }

    gettimeofday(&m_beginTime, NULL);
    ExecDML();
    gettimeofday(&m_endTime, NULL);
    m_elapsedTime = ElapsedTime(&m_beginTime, &m_endTime);
    totalTime();
    fclose(fp);

    logout();

    return 0;
}
