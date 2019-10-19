COMPILE.c=gcc -D_GNU_SOURCE -W -Wall -pipe -D_POSIX_PTHREAD_SEMANTICS -D_POSIX_THREADS -D_POSIX_THREAD_SAFE_FUNCTIONS -D_REENTRANT -DPDL_HAS_AIO_CALLS -m32 -mtune=i686 -O3 -ffloat-store -fno-strict-aliasing -DPDL_NDEBUG -D_GNU_SOURCE -DACP_CFG_COMPILE_32BIT -DACP_CFG_COMPILE_BIT=32 -DACP_CFG_COMPILE_BIT_STR=32 -c
SHCOMPILE.c=
CCOUT=-o
LD=g++
LFLAGS=-L. -O3 -funroll-loops -m32
ODBC_LIBS=-lodbc
LIBS= -ldl -lpthread -lcrypt -lrt -lstdc++
SH_LIBS= -ldl -lpthread -lcrypt -lrt -lstdc++
IDROPT=-I
LDROPT=-L
