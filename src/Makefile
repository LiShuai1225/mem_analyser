#
#	shuke.wang
#	2015/07/20
#

CC		= g++

LIBS	= -ldwarf -lelf -lpopt
CFLAGS	= -Wall

TARGET	= mem_analyser
OBJS	= main.cc parse.cc


all: $(TARGET)
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LIBDIR) $(LIBS) -o $@

clean:
	rm -f *.o
	rm -f $(TARGET)
	
