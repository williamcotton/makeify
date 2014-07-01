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

public/index.html: 
	./node_modules/.bin/swig render src/shtml/index.shtml -j package.json > $@