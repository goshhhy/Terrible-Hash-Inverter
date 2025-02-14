CC = gcc
CFLAGS = -O3 -std=c11 -march=native -Wall -Wextra -Werror -flto
LINKER = gcc
LFLAGS = -fuse-ld=gold -pthread -flto
OBJS = basilisk.o crypto/sha2.o crypto/sha256_sse4.o crypto/sha256_avx1.o crypto/sha256_avx2_rorx2.o

all : gen benchmark

gen : gen.o $(OBJS)
	$(LINKER) $(LFLAGS) -o $@ $^

benchmark : benchmark.o $(OBJS)
	$(LINKER) $(LFLAGS) -o $@ $^

sha256_%.o : sha256_%.asm
	yasm -f x64 -f elf64 -X gnu -g dwarf2 -D LINUX -o $@ $^

%.o : %.c %.h Makefile
	$(CC) $(CFLAGS) -c -o $*.o $*.c

