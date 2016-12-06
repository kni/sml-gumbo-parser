all: gumbo-constants.sml

gumbo-constants.sml: gumbo-constants.c
	cc -I/usr/local/include -o gumbo-constants gumbo-constants.c && ./gumbo-constants > gumbo-constants.sml && rm gumbo-constants

gen:
	perl gen.pl

clean:
	rm -rf gumbo-constants.sml
