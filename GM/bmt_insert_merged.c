#include <assert.h>
#include <limits.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include <sqlcli.h>

typedef struct threadContext {
    pthread_mutex_t connected;
    char            connection[1024];
    int             minimum;
    int             maximum;
    long long       sum;
    int             numberOfTransactions;
    int             numberOfLongTransactions;
} threadContext;

int numberOfThreads;
int startValue;
int numberOfTransactions;
int sizeOfUnit;
int threshold;
int cap;

struct timeval connectTime;
struct timeval startTime;
struct timeval endTime;

pthread_mutex_t* mutex;
int*             remain;
int*             cursor;
int*             allocated;

char user[1024];
char password[1024];
char option[1024];

int compareThreadContexts ( const void* element1, const void* element2 ) {
    
    const threadContext* context1;
    const threadContext* context2;
    
    context1 = (const threadContext*)element1;
    context2 = (const threadContext*)element2;
    
    if ( context1->numberOfTransactions < context2->numberOfTransactions ) return -1;
    if ( context1->numberOfTransactions > context2->numberOfTransactions ) return  1;
    
    return 0;
    
}

int allocateUnit ( int* start, int* end ) {
    
    int size;
    int elapsed;
    
    assert( pthread_mutex_lock( mutex ) == 0 );
    
    if ( cap > 0 ) {
        assert( gettimeofday( &endTime, NULL ) == 0 );
        if ( endTime.tv_usec > startTime.tv_usec ) {
            elapsed = ( endTime.tv_sec  - startTime.tv_sec ) * 1000000 + ( endTime.tv_usec - startTime.tv_usec );
        } else {
            elapsed = ( endTime.tv_sec  - 1 - startTime.tv_sec ) * 1000000 + ( endTime.tv_usec + 1000000 - startTime.tv_usec );
        }
        while ( (double)(*allocated) / ( (double)elapsed / 1000000. ) > (double)cap ) {
            sched_yield();
            assert( gettimeofday( &endTime, NULL ) == 0 );
            if ( endTime.tv_usec > startTime.tv_usec ) {
                elapsed = ( endTime.tv_sec  - startTime.tv_sec ) * 1000000 + ( endTime.tv_usec - startTime.tv_usec );
            } else {
                elapsed = ( endTime.tv_sec  - 1 - startTime.tv_sec ) * 1000000 + ( endTime.tv_usec + 1000000 - startTime.tv_usec );
            }
        }
    }
    
    if ( (*remain) > sizeOfUnit ) {
        size       = sizeOfUnit;
        (*remain) -= sizeOfUnit;
    } else {
        size       = (*remain);
        (*remain) -= (*remain);
    }
    *start        = (*cursor);
    *end          = (*cursor) + size;
    (*cursor)    += size;
    (*allocated) += size;
    
    assert( pthread_mutex_unlock( mutex ) == 0 );
    
    return size;
      
}

#define DESCRIPTION "SIMPLE_BENCHMARK_INSERT_HDB_CLI_THREAD"

void* worker ( void* argument ) {
    
    char           connection[1024];
    SQLHENV        env;
    SQLHDBC        dbc;
    SQLHSTMT       stmt;
    int            k01;
    int            k02;
    int            k03;
    int            k04;
    int            k05;
    int            k06;
    int            k07;
    int            k08;
    int            k09;
    int            k10;
    int            k11;
    int            k12;
    int            k13;
    int            k14;
    int            k15;
    int            k16;
    int            k17;
    int            k18;
    int            k19;
    int            k20;
    int            k21;
    int            k22;
    int            k23;
    int            k24;
    int            k25;
    int            k26;
    int            k27;
    int            k28;
    int            k29;
    int            k30;
    int            k31;
    int            k32;
    int            k33;
    int            k34;
    int            k35;
    int            k36;
    int            k37;
    int            k38;
    int            k39;
    int            k40;
    int            k41;
    int            k42;
    int            k43;
    int            k44;
    int            k45;
    char           k46[31];
    char           k47[31];
    char           k48[31];
    char           k49[31];
    char           k50[31];

    int            lvalue;
    
    int            start;
    int            end;
    int            value;
    struct timeval startTime;
    struct timeval endTime;
    int            elapsed;
    
    memset( k46, 0, sizeof(k46) );
    memset( k47, 0, sizeof(k47) );
    memset( k48, 0, sizeof(k48) );
    memset( k49, 0, sizeof(k49) );
    memset( k50, 0, sizeof(k50) );
    strcpy( k46, "test_insert_coscom1" );
    strcpy( k47, "abcdefghijklmnopqrs" );
    strcpy( k48, "abcdefghijklmnopqrs" );
    strcpy( k49, "0123456789012345678" );
    strcpy( k50, "test_insert_coscom2" );
    
    threadContext* context = (threadContext*)argument;
    
    sprintf( connection, "%s;UID=%s;PWD=%s", option, user, password );
    
    assert( SQLAllocEnv( &env ) == SQL_SUCCESS );
    
    assert( SQLAllocConnect( env, &dbc ) == SQL_SUCCESS );
    
    assert( SQLDriverConnect( dbc, NULL, connection, SQL_NTS, NULL, 0, NULL, SQL_DRIVER_NOPROMPT ) == SQL_SUCCESS );
    
    assert( SQLAllocStmt( dbc, &stmt ) == SQL_SUCCESS );
    
    assert( SQLPrepare( stmt, "INSERT INTO TEST VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )", SQL_NTS ) == SQL_SUCCESS );
    
    assert( SQLBindParameter( stmt,  1, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k01, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt,  2, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k02, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt,  3, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k03, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt,  4, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k04, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt,  5, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k05, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt,  6, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k06, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt,  7, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k07, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt,  8, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k08, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt,  9, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k09, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 10, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k10, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 11, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k11, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 12, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k12, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 13, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k13, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 14, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k14, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 15, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k15, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 16, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k16, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 17, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k17, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 18, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k18, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 19, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k19, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 20, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k20, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 21, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k21, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 22, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k22, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 23, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k23, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 24, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k24, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 25, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k25, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 26, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k26, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 27, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k27, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 28, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k28, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 29, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k29, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 30, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k30, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 31, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k31, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 32, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k32, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 33, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k33, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 34, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k34, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 35, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k35, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 36, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k36, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 37, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k37, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 38, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k38, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 39, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k39, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 40, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k40, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 41, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k41, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 42, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k42, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 43, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k43, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 44, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k44, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 45, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER,  0, 0, &k45, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 46, SQL_PARAM_INPUT, SQL_C_CHAR,  SQL_VARCHAR, 30, 0, &k46, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 47, SQL_PARAM_INPUT, SQL_C_CHAR,  SQL_VARCHAR, 30, 0, &k47, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 48, SQL_PARAM_INPUT, SQL_C_CHAR,  SQL_VARCHAR, 30, 0, &k48, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 49, SQL_PARAM_INPUT, SQL_C_CHAR,  SQL_VARCHAR, 30, 0, &k49, 0, NULL ) == SQL_SUCCESS );
    assert( SQLBindParameter( stmt, 50, SQL_PARAM_INPUT, SQL_C_CHAR,  SQL_VARCHAR, 30, 0, &k50, 0, NULL ) == SQL_SUCCESS );
    
    assert( pthread_mutex_unlock( &(context->connected) ) == 0 );
    
    while ( allocateUnit( &start, &end ) > 0 ) {

	lvalue = 1;
        
        for ( value = start; value < end; value++ ) {
            
            assert( gettimeofday( &startTime, NULL ) == 0 );
            
            k01 = value;

            k02 = lvalue++;   // list [1,2,3,4,5]
	    if(lvalue > 4) lvalue=1;	

            k03 = value;
            k04 = value;
            k05 = value;
            k06 = value;
            k07 = value;
            k08 = value;
            k09 = value;
            k10 = value;
            k11 = value;
            k12 = value;
            k13 = value;
            k14 = value;
            k15 = value;
            k16 = value;
            k17 = value;
            k18 = value;
            k19 = value;
            k20 = value;
            k21 = value;
            k22 = value;
            k23 = value;
            k24 = value;
            k25 = value;
            k26 = value;
            k27 = value;
            k28 = value;
            k29 = value;
            k30 = value;
            k31 = value;
            k32 = value;
            k33 = value;
            k34 = value;
            k35 = value;
            k36 = value;
            k37 = value;
            k38 = value;
            k39 = value;
            k40 = value;
            k41 = value;
            k42 = value;
            k43 = value;
            k44 = value;
            k45 = value;
            
            assert( SQLExecute( stmt ) == SQL_SUCCESS );
            
            assert( gettimeofday( &endTime, NULL ) == 0 );
            
            if ( endTime.tv_usec > startTime.tv_usec ) {
                elapsed = ( endTime.tv_sec  - startTime.tv_sec ) * 1000000 + ( endTime.tv_usec - startTime.tv_usec );
            } else {
                elapsed = ( endTime.tv_sec  - 1 - startTime.tv_sec ) * 1000000 + ( endTime.tv_usec + 1000000 - startTime.tv_usec );
            }
            
            if ( context->minimum > elapsed ) context->minimum = elapsed;
            if ( context->maximum < elapsed ) context->maximum = elapsed;
            context->sum += elapsed;
            context->numberOfTransactions++;
            if ( elapsed >= threshold ) context->numberOfLongTransactions++;
            
        }
        
    }
    
    assert( SQLFreeStmt( stmt, SQL_DROP ) == SQL_SUCCESS );
    
    assert( SQLDisconnect( dbc ) == SQL_SUCCESS );
    
    assert( SQLFreeConnect( dbc ) == SQL_SUCCESS );
    
    assert( SQLFreeEnv( env ) == SQL_SUCCESS );    
    
    return argument;
    
}

int main( int argc, char* argv[] ) {
    
    threadContext*      contexts;
    pthread_attr_t      threadAttribute;
    int                 thread;
    pthread_t*          threads;
    void*               value;
    struct tm*          tm;
    long long           second;
    long long           usecond;
    long long           elapsed;
    double              tps;
    int                 minimum;
    int                 maximum;
    long long           sum;
    int                 numberOfLongTransactions;
    int                 average;
    
    numberOfThreads      = 1;
    startValue           = 0;
    numberOfTransactions = 1000000;
    sizeOfUnit           = 1000;
    threshold            = 1000000;
    cap                  = 0;
    strcpy( user,          "SYS" );
    strcpy( password,      "MANAGER" );
    strcpy( option,        "DSN=localhost;PORT_NO=20300;CONN_TYPE=2" );
    
    switch( argc ) {
     case 10:
        strcpy( option,        argv[9] );
     case 9:
        strcpy( password,      argv[8] );
     case 8:
        strcpy( user,          argv[7] );
     case 7:
        cap                  = atoi( argv[6] );
     case 6:
        threshold            = atoi( argv[5] );
     case 5:
        sizeOfUnit           = atoi( argv[4] );
     case 4:
        numberOfTransactions = atoi( argv[3] );
     case 3:
        startValue           = atoi( argv[2] );
     case 2:
        numberOfThreads      = atoi( argv[1] );
        break;
     default:
        printf( "Usage: %s numberOfThreads [startValue] [numberOfTransactions] [sizeOfUnit] [threshold] [cap] [user] [password] [option]\n", argv[0] );
        exit( EXIT_FAILURE );
        break;
    }
    
    printf( "Description                       : %s\n",  DESCRIPTION          );
    //printf( "Number of Threads                 : %8d\n", numberOfThreads      );
    printf( "Start Value                       : %8d\n", startValue           );
    printf( "Number of Transactions            : %8d\n", numberOfTransactions );
    printf( "Size   of Unit                    : %8d\n", sizeOfUnit           );
    printf( "Threshold(microsecond)            : %8d\n", threshold            );
    printf( "Cap(TPS)                          : %8d\n", cap                  );
    printf( "User                              : %s\n",  user                 );
    printf( "Password                          : %s\n",  password             );
    printf( "Option                            : %s\n",  option               );
    
    contexts = malloc( sizeof(threadContext) * numberOfThreads );
    assert( contexts != NULL );
    memset( contexts, 0, sizeof(threadContext) * numberOfThreads );
    for ( thread = 0; thread < numberOfThreads; thread++ ) {
        assert( pthread_mutex_init( &(contexts[thread].connected), NULL ) == 0 );
        sprintf( contexts[thread].connection, "%d", thread );
        contexts[thread].minimum                  = INT_MAX;
        contexts[thread].maximum                  = 0;
        contexts[thread].sum                      = 0;
        contexts[thread].numberOfTransactions     = 0;
        contexts[thread].numberOfLongTransactions = 0;
    }
    
    threads = malloc( sizeof(pthread_t) * numberOfThreads );
    assert( threads != NULL );
    
    mutex = malloc( sizeof(pthread_mutex_t) );
    assert( mutex != NULL );
    remain = malloc( sizeof(int) );
    assert( remain != NULL );
    cursor = malloc( sizeof(int) );
    assert( cursor != NULL );
    allocated = malloc( sizeof(int) );
    assert( allocated != NULL );
    
    assert( pthread_mutex_init( mutex, NULL ) == 0 );
    
    *remain    = numberOfTransactions;
    *cursor    = startValue;
    *allocated = 0;
    
    assert( pthread_attr_init( &threadAttribute ) == 0 );
    assert( pthread_attr_setscope( &threadAttribute, PTHREAD_SCOPE_SYSTEM ) == 0 );
    
    fflush( stdout );
    fflush( stderr );

    assert( gettimeofday( &connectTime, NULL ) == 0 );

    assert( pthread_mutex_lock( mutex ) == 0 );

    for ( thread = 0; thread < numberOfThreads; thread++ ) {
        assert( pthread_mutex_lock( &(contexts[thread].connected) ) == 0 );
        assert( pthread_create( threads + thread, &threadAttribute, worker, contexts + thread ) == 0 );
    }

    for ( thread = 0; thread < numberOfThreads; thread++ ) {
        assert( pthread_mutex_lock( &(contexts[thread].connected) ) == 0 );
        assert( pthread_mutex_unlock( &(contexts[thread].connected) ) == 0 );
    }

    assert( gettimeofday( &startTime, NULL ) == 0 );
    if ( startTime.tv_usec > connectTime.tv_usec ) {
        second  = startTime.tv_sec  - connectTime.tv_sec;
        usecond = startTime.tv_usec - connectTime.tv_usec;
    } else {
        second  = startTime.tv_sec  -       1 - connectTime.tv_sec;
        usecond = startTime.tv_usec + 1000000 - connectTime.tv_usec;
    }
    printf( "Connection Elapsed                : %llu.%06llu second\n", second, usecond );
    tm = localtime( &(startTime.tv_sec) );
    printf( "Start Time                        : %04u/%02u/%02u %02u:%02u:%02u.%06u\n", (unsigned int)(1900+tm->tm_year), (unsigned int)(tm->tm_mon+1), (unsigned int)(tm->tm_mday), (unsigned int)(tm->tm_hour), (unsigned int)(tm->tm_min), (unsigned int)(tm->tm_sec), (unsigned int)(startTime.tv_usec) );
    
    assert( pthread_mutex_unlock( mutex ) == 0 );
    
    fflush( stdout );
    fflush( stderr );
    
    for ( thread = 0; thread < numberOfThreads; thread++ ) {
        assert( pthread_join( threads[thread], &value ) == 0 );
    }
    
    assert( gettimeofday( &endTime, NULL ) == 0 );
    tm = localtime( &(endTime.tv_sec) );
    printf( "End   Time                        : %04u/%02u/%02u %02u:%02u:%02u.%06u\n", (unsigned int)(1900+tm->tm_year), (unsigned int)(tm->tm_mon+1), (unsigned int)(tm->tm_mday), (unsigned int)(tm->tm_hour), (unsigned int)(tm->tm_min), (unsigned int)(tm->tm_sec), (unsigned int)(endTime.tv_usec) );
    
    assert( pthread_attr_destroy( &threadAttribute ) == 0 );
    
    assert( pthread_mutex_destroy( mutex ) == 0 );
    
    qsort( contexts, numberOfThreads, sizeof(threadContext), compareThreadContexts );
    
    minimum                  = INT_MAX;
    maximum                  = 0;
    sum                      = 0;
    numberOfLongTransactions = 0;
    for ( thread = 0; thread < numberOfThreads; thread++ ) {
        if ( minimum > contexts[thread].minimum ) minimum = contexts[thread].minimum;
        if ( maximum < contexts[thread].maximum ) maximum = contexts[thread].maximum;
        sum                      += contexts[thread].sum;
        numberOfLongTransactions += contexts[thread].numberOfLongTransactions;
    }
    average = (int)( (double)sum / (double)numberOfTransactions );
    
    if ( endTime.tv_usec > startTime.tv_usec ) {
        second  = endTime.tv_sec  - startTime.tv_sec;
        usecond = endTime.tv_usec - startTime.tv_usec;
    } else {
        second  = endTime.tv_sec  -       1 - startTime.tv_sec;
        usecond = endTime.tv_usec + 1000000 - startTime.tv_usec;
    }
    printf( "Elapsed                           : %llu.%06llu second\n", second, usecond );
    
    elapsed = second * 1000000 + usecond;
    tps = (double)numberOfTransactions / ( (double)elapsed / 1e6 );
    printf( "Transactions per Second           : %9.2f TPS\n", tps );
    printf( "Minimum                           : %6d microseconds\n", minimum );
    printf( "Maximum                           : %6d microseconds\n", maximum );
    printf( "Average                           : %6d microseconds\n", average );
    printf( "Number of Long Transactions       : %6.2f%% ( %d / %d )\n", (double)numberOfLongTransactions / (double)numberOfTransactions * 100, numberOfLongTransactions, numberOfTransactions );
    //printf( "Number of Transactions per Thread :" );
    //for ( thread = 0; thread < numberOfThreads; thread++ ) {
    //    printf( " %d", contexts[thread].numberOfTransactions );
    // }
    printf( "\n" );
    printf( "\n" );
    
    return EXIT_SUCCESS;
    
}
