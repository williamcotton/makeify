all: node_modules clean build

node_modules:
	npm install

postinstall: build

build: build_directories public/index.js public/index.css public/index.html

deep_clean: clean
	rm -rf node_modules

clean:
	rm -rf tmp
	rm -rf public

build_directories:
	mkdir -p tmp
	mkdir -p public

tmp/index.browserify.js:
	./node_modules/.bin/browserify src/js/index.js -t reactify > $@

tmp/index.uglify.js: tmp/index.browserify.js
	./node_modules/.bin/uglifyjs $< -m -c > $@

public/index.js: tmp/index.uglify.js
	cp $< $@

public/index.css:
	./node_modules/.bin/node-sass src/scss/index.scss $@ --output-style compressed

public/index.swig.html: 
	./node_modules/.bin/swig render src/shtml/index-inline.shtml -j package.json > $@

public/index.html: public/index.swig.html
	./node_modules/.bin/html-inline -i $< -o $@

build_non_inline: 
	./node_modules/.bin/swig render src/shtml/index.shtml -j package.json > public/index.html

# Debug builds with source maps

build_debug: build_debug_css build_debug_js

build_debug_css: clean_css
	./node_modules/.bin/node-sass src/scss/index.scss public/index.css --source-map

build_debug_js: clean_js
	./node_modules/.bin/browserify src/js/index.js -t reactify > public/index.js -d

clean_css:
	rm -f public/index.css
	rm -f public/index.css.map

clean_js:
	rm -f public/index.js