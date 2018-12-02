RM=rm
MKDIR=mkdir
CC=gcc
STRIP=strip

OUTDIR=build
OUTFILE="$(OUTDIR)/rtl_wmbus"
CFLAGS=-Iinclude -std=gnu99
CFLAGS_WARNINGS=
LIB=-lm 
SRC=rtl_wmbus.c

all: $(OUTDIR) release

$(OUTDIR):
	$(MKDIR) -p "$(OUTDIR)"

release: $(OUTDIR)
	$(CC) -DNDEBUG -O3                  $(CFLAGS) $(CFLAGS_WARNINGS) -o $(OUTFILE) $(SRC) $(LIB)

debug: $(OUTDIR)
	$(CC) -DDEBUG  -O0 -g3 -ggdb -p -pg $(CFLAGS) $(CFLAGS_WARNINGS) -o $(OUTFILE) $(SRC) $(LIB)

# Will build on Raspberry Pi 1 only
pi1:
	$(CC) -DNDEBUG -O3 -march=armv6 -mtune=arm1176jzf-s -mfloat-abi=hard -mfpu=vfp -ffast-math $(CFLAGS) $(CFLAGS_WARNINGS) -o $(OUTFILE) $(SRC) $(LIB)

rebuild: clean all

clean:
	$(RM) -rf "$(OUTDIR)"
