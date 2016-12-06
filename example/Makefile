GUMBO_FILES := ../gumbo-common.sml ../gumbo-common.sig ../gumbo-constants.sml ../gumbo-mlton.sml ../gumbo.sig

all:
	@echo "targets: poly mlton clean"

../gumbo-constants.sml:
	@cd .. && ${MAKE}

poly: example-poly
	./example-poly example.html

mlton: example-mlton
	./example-mlton example.html

example-poly: ${GUMBO_FILES} example.sml example.mlp
	polyc -o example-poly example.mlp

example-mlton: ${GUMBO_FILES} example.sml example.mlb
	mlton -default-ann 'allowFFI true' -link-opt -lgumbo -output example-mlton example.mlb



clean:
	rm -rf example-poly example-mlton
