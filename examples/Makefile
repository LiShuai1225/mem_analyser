

LIBDIR= -L../libdwarf
LIBS= -ldwarf -lelf
CFLAGS= -Wall -I../libdwarf

all: simplereader frame1 readelf

simplereader: simplereader.c
	$(CC) $(CFLAGS) simplereader.c -o simplereader $(LIBDIR) $(LIBS)
frame1: frame1.c
	$(CC) $(CFLAGS) frame1.c -o frame1 $(LIBDIR) $(LIBS)
readelf: readelf.c
	$(CC) $(CFLAGS) readelf.c -o readelf $(LIBDIR) $(LIBS)

clean:
	rm -f simplereader.o
	rm -f simplereader
	rm -f frame1
	rm -f frame1.o
	rm -f readelf
	rm -f readelf.o
