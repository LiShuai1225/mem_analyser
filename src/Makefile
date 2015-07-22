#
#	shuke.wang
#	2015/07/20
#

LIBS	= -ldwarf -lelf
CFLAGS	= -Wall

TARGET	= mem_analyser
OBJS	= main.c


all: $(TARGET)
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LIBDIR) $(LIBS) -o $@

clean:
	rm -f *.o
	rm -f $(TARGET)
