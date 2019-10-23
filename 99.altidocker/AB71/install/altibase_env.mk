###############################################################################
#  Copyright 1999-2006, AltiBase Corporation or its subsidiaries.
#  All rights reserved.
###############################################################################

###############################################################################
# $Id: altibase_env_head.mk 15752 2006-05-16 00:23:46Z sjkim $
###############################################################################
Q=@
NM=/usr/bin/nm
NMFLAGS=-t x
OS_TARGET=X86_64_LINUX
OS_MAJORVER=0
OS_MINORVER=0
OS_LINUX_PACKAGE=redhat_Enterprise
OS_LINUX_VERSION=release6.0
OS_LINUX_KERNEL=1
compile64=1
compat5=1
CXX=g++
CC=gcc
AR=ar
COMPILE.cc=g++ -D_GNU_SOURCE -D_GNU_SOURCE -W -Wall -pipe -D_POSIX_PTHREAD_SEMANTICS -D_POSIX_THREADS -D_POSIX_THREAD_SAFE_FUNCTIONS -D_REENTRANT -DPDL_HAS_AIO_CALLS -m64 -mtune=k8 -O3 -funroll-loops -fno-strict-aliasing -fno-omit-frame-pointer -DPDL_NDEBUG -fno-implicit-templates -Wno-deprecated -O3 -funroll-loops -fno-strict-aliasing -fno-omit-frame-pointer -fno-exceptions -fcheck-new -D__PDL_INLINE__ -DPDL_LACKS_PDL_TOKEN -DPDL_LACKS_PDL_OTHER -DACP_CFG_COMPILE_64BIT -DACP_CFG_COMPILE_BIT=64 -DACP_CFG_COMPILE_BIT_STR=64 -DCOMPILER_OPT_FLAGS="-O3 -funroll-loops -fno-strict-aliasing -fno-omit-frame-pointer" -MMD -MP -c
COMPILE.c=gcc -D_GNU_SOURCE -W -Wall -pipe -D_POSIX_PTHREAD_SEMANTICS -D_POSIX_THREADS -D_POSIX_THREAD_SAFE_FUNCTIONS -D_REENTRANT -DPDL_HAS_AIO_CALLS -m64 -mtune=k8 -O3 -funroll-loops -fno-strict-aliasing -fno-omit-frame-pointer -DPDL_NDEBUG -D_GNU_SOURCE -DACP_CFG_COMPILE_64BIT -DACP_CFG_COMPILE_BIT=64 -DACP_CFG_COMPILE_BIT_STR=64 -DCOMPILER_OPT_FLAGS="-O3 -funroll-loops -fno-strict-aliasing -fno-omit-frame-pointer" -MMD -MP -c
SHCOMPILE.cc=
SHCOMPILE.c=
DEFOPT=-D
IDROPT=-I
LDROPT=-L
LIBOPT=-l
LIBAFT=
AROUT=
LDOUT=-o
SOOUT=-o
CCOUT=-o
ARFLAGS=-ruv
DEFINES=-D_REENTRANT
CCFLAGS=-D_GNU_SOURCE -D_GNU_SOURCE -W -Wall -pipe -D_POSIX_PTHREAD_SEMANTICS -D_POSIX_THREADS -D_POSIX_THREAD_SAFE_FUNCTIONS -D_REENTRANT -DPDL_HAS_AIO_CALLS -m64 -mtune=k8 -O3 -funroll-loops -fno-strict-aliasing -fno-omit-frame-pointer -DPDL_NDEBUG -fno-implicit-templates -Wno-deprecated -O3 -funroll-loops -fno-strict-aliasing -fno-omit-frame-pointer -fno-exceptions -fcheck-new -D__PDL_INLINE__ -DPDL_LACKS_PDL_TOKEN -DPDL_LACKS_PDL_OTHER -DACP_CFG_COMPILE_64BIT -DACP_CFG_COMPILE_BIT=64 -DACP_CFG_COMPILE_BIT_STR=64
CFLAGS=-D_GNU_SOURCE -W -Wall -pipe -D_POSIX_PTHREAD_SEMANTICS -D_POSIX_THREADS -D_POSIX_THREAD_SAFE_FUNCTIONS -D_REENTRANT -DPDL_HAS_AIO_CALLS -m64 -mtune=k8 -O3 -funroll-loops -fno-strict-aliasing -fno-omit-frame-pointer -DPDL_NDEBUG -D_GNU_SOURCE -DACP_CFG_COMPILE_64BIT -DACP_CFG_COMPILE_BIT=64 -DACP_CFG_COMPILE_BIT_STR=64
DCFLAGS=-g -DDEBUG
DCCFLAGS=-g -DDEBUG
OCFLAGS=-O3 -funroll-loops -fno-strict-aliasing -fno-omit-frame-pointer
OCCFLAGS=-O3 -funroll-loops -fno-strict-aliasing -fno-omit-frame-pointer
EFLAGS=-E -D_POSIX_PTHREAD_SEMANTICS -D__ACE_INLINE__ -DACE_LACKS_ACE_TOKEN -DACE_LACKS_ACE_OTHER -O3
SFLAGS=-S -D_POSIX_PTHREAD_SEMANTICS -D__ACE_INLINE__ -DACE_LACKS_ACE_TOKEN -DACE_LACKS_ACE_OTHER -O3
LD=g++
LFLAGS=-Wl,-relax -Wl,--no-as-needed -L. -O3
OBJEXT=o
SOEXT=so
BINEXT=
LIBEXT=a
LIBPRE=lib
COPY=cp
RM=rm -rf
ODBC_INCLUDES=-I/usr/local/odbcDriverManager64/include
ODBC_LIBDIRS=-L/usr/local/odbcDriverManager64/lib
ODBC_LIBS=-lodbc
LIBS= -ldl -lpthread -lcrypt -lrt -lstdc++
SH_LIBS= -ldl -lpthread -lcrypt -lrt -lstdc++
RTL_FLAG=
LDOUT +=  # intentionally put this 
SOOUT +=  # intentionally put this 
CCOUT +=  # intentionally put this 
SOLINK.cc= g++ -DCOMPILER_OPT_FLAGS="-O3 -funroll-loops -fno-strict-aliasing -fno-omit-frame-pointer" -MMD -MP -shared
SOFLAGS= -DCOMPILER_OPT_FLAGS="-O3 -funroll-loops -fno-strict-aliasing -fno-omit-frame-pointer" -MMD -MP -shared
PIC=-fPIC
INCLUDES = $(IDROPT)$(ALTIBASE_HOME)/include $(IDROPT).
LIBDIRS = $(LDROPT)$(ALTIBASE_HOME)/lib
LFLAGS += $(LIBDIRS)

########################
#### common rules
########################
%.$(OBJEXT): %.cpp
	$(COMPILE.cc) $(INCLUDES) $(CCOUT)$@ $<

%.p: %.cpp
	$(CXX) $(EFLAGS) $(DEFINES) $(INCLUDES) $< > $@

%.s: %.cpp
	$(CXX) $(SFLAGS) $(DEFINES) $(INCLUDES) $< > $@

%.$(OBJEXT): %.c
	$(COMPILE.c) $(INCLUDES) $(CCOUT)$@ $<

