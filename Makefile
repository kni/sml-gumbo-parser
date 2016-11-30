all:
	@echo "targets: poly mlton clean"

poly: example-poly
	./example-poly example.html

mlton: example-mlton
	./example-mlton example.html

example-poly: gumbo-common.sml gumbo-common.sig gumbo-constants.sml gumbo-poly.sml gumbo.sig example.sml example.mlp
	polyc -o example-poly example.mlp

example-mlton: gumbo-common.sml gumbo-common.sig gumbo-constants.sml gumbo-mlton.sml gumbo.sig example.sml example.mlb
	mlton -default-ann 'allowFFI true' -link-opt -lgumbo -output example-mlton example.mlb

gumbo-constants.sml: gumbo-constants.c
	cc -I/usr/local/include -o gumbo-constants gumbo-constants.c && ./gumbo-constants > gumbo-constants.sml && rm gumbo-constants

gen:
	perl gen.pl

clean:
	rm -rf example-poly example-mlton gumbo-constants.sml
