#include <errno.h>
#include <math.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    double a = 0;
    double b = 0;
    double c = 0;
    double qphh1 = 0;
    double qphh2 = 0;
    char   line[128];
    FILE *in = NULL;
    int scale = 0;
    int stream = 0;

    if( atoi(argv[1]) == 1 ) // TPC-H Power
    {
	scale = atoi(argv[2]);

        in = fopen("runP.log", "r");
        if( in == NULL ) 
        {
            printf("fopen error: %d\n", errno );
            exit(-1);
        }

        while( 1 )
        {
            if( fgets(line, sizeof(line), in) != NULL )
            {
                a  += log(atof(line));
            }
            else 
            {
                break;
            }
        }
        fclose(in);

        b = -(1/24.0) * a;

        c = exp(b);

        qphh1 = 3600.0 * c * scale;

        printf( "%f\n", qphh1 );
    }
    else if( atoi(argv[1]) == 2 ) // TPC-H Thoughput 
    {
        scale = atoi( argv[2] );
        stream = atoi( argv[3] );

        in = fopen("runT.log", "r");
        if( in == NULL ) 
        {
            printf("fopen error: %d\n", errno );
            exit(-1);
        }

        while( 1 )
        {
            if( fgets(line, sizeof(line), in) != NULL )
            {
                a += atof(line);
            }
            else 
            {
                break;
            }
        }
        fclose(in);

        qphh2 = (stream * 22 * 3600) / a * scale;

        printf( "%f\n", qphh2 );
    }
    else if( atoi(argv[1]) == 3 ) // TPC-H QphH
    {
        qphh1 = atof( argv[2] );
        qphh2 = atof( argv[3] );
        printf( "%f\n", sqrt( qphh1 * qphh2));
    }

    return 0;
}
