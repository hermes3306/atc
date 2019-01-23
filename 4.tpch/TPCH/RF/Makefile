include $(ALTIBASE_HOME)/install/altibase_env.mk

BINS=RF2

SRCS = RF2.sc

SESS=$(SRCS:.sc=.c)
OBJS=$(SRCS:.c=.o)

%.c : %.sc
	sesc $<

all: $(BINS)

RF2: RF2.o RF2.c
	$(LD) $(LFLAGS) $(GOPT) $(INCLUDES) -o RF2 RF2.o -lsesc -lodbccli $(LIBS)

clean:
	-rm -rf $(BINS) $(SESS) RF2.c RF2.d RF2 *.o core

