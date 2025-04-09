.PHONY: clean all
CFLAGS = -Wall -g -O2
targets = hello world
sources = main.c message.c
objects = main.o message.o

all: $(targets)
	@echo "all done"

$(targets): $(objects)
	gcc $(CFLAGS) $(objects) -o $@

%.o: %.c 
	gcc $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o hello world