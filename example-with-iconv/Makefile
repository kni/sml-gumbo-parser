GUMBO_FILES := ../gumbo-common.sml ../gumbo-common.sig ../gumbo-constants.sml ../gumbo-mlton.sml ../gumbo.sig

all:
	@echo "targets: poly mlton clean"

../gumbo-constants.sml:
	@cd .. && ${MAKE}

poly: example-poly
	./example-poly utf-8.html

mlton: example-mlton
	./example-mlton utf-8.html

example-poly: ${GUMBO_FILES} ../example/example-parse.sml example.sml example.mlp iconv scancom
	polyc -o example-poly example.mlp

example-mlton: ${GUMBO_FILES} ../example/example-parse.sml example.sml example.mlb iconv scancom
	mlton -default-ann 'allowFFI true' -link-opt -lgumbo -output example-mlton example.mlb

iconv:
	git clone https://github.com/kni/sml-iconv.git iconv

scancom:
	git clone https://github.com/kni/scancom.git scancom

clean:
	rm -f example-poly example-mlton

realclean: clean
	rm -rf iconv scancom

