include $(ALTIBASE_HOME)/install/altibase_env.mk

BINS=qphh

SRCS = qphh.cpp 

all: $(BINS)

qphh: qphh.o 
	$(LD) $(LFLAGS) $(GOPT) $(INCLUDES) -o qphh qphh.cpp -lsesc -lodbccli $(LIBS)

clean:
	-rm -rf $(BINS) $(SESS) qphh.o core qphh.d

