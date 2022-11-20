.PHONY: mjml-prepare mjml-replace-general mjml-replace-specific

default: mjml-prepare mjml-replace-general mjml-replace-specific

mjml-prepare:
	clear

	@rm -fr lib
	git restore .

# Remove node files
	@rm -fr node_modules package-lock.json yarn.lock lerna.json

# Remove some files that breaks browser compatibility
	@rm -fr \
		./packages/mjml-cli \
		./packages/mjml/bin \
		./packages/mjml-browser \
		./packages/mjml-migrate/src/cli.js \
		./packages/mjml-core/src/helpers/mjmlconfig.js

# Remove lib from .gitignore
	@sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#lib\n##g" .gitignore

# Add package-lock.json to .gitignore
	@echo "package-lock.json" >> .gitignore

# Delete package.json files
	find ./ -name package.json -delete

# Move all package files out of "src" dirs
	find ./packages -depth 1 -execdir bash -c "mv ./{}/src/* ./{}/" ';'

# Delete src dirs
	find ./packages -name src -delete

# Move packages dir to lib
	mv ./packages ./lib

# Consolidate the main files to always be index.js
	mv ./lib/mjml-migrate/migrate.js ./lib/mjml-migrate/index.js

# Create the modules index.js file, which should just re-export other modules
	echo "import mjml2html from './lib/mjml/index.js'\n$ \
import migrate from './lib/mjml-migrate/index.js'\n\n$ \
export {\n$ \
  mjml2html,\n$ \
  migrate\n$ \
}$ \
" > index.js

# Create the new package.json 
	npm init -y
	sed -I '' -r 's#([ ]*)("version": .*"1.0.0",)#\1\2\n\1"type": "module",#g' package.json

# Ensure that we have the needed dependencies
	npm i --save-dev lodash juice


mjml-replace-general:
# Add ./ and /index to all import paths containing /mjml-*/
	@for file in $(shell find ./lib -type f -name "*.js") ; do \
		sed -I '' -r -e "s#from '(mjml[^'/]*)'#from '../\1/index'#g" $$file ; \
		sed -I '' -r -e "s#from '(mjml[^']*)'#from '../\1'#g" $$file ; \
	done

# Add .js and the correct amount of ../ to import paths containing ./
	@for file in $(shell find ./lib -depth 2 -type f -name "*.js") ; do \
		sed -I '' -r -e "s#from '\.\./[\./]*(mjml[^']+)'#from '../\1'#g" $$file ; \
	done
	@for file in $(shell find ./lib -depth 3 -type f -name "*.js") ; do \
		sed -I '' -r -e "s#from '\.\./[\./]*(mjml[^']+)'#from '../../\1'#g" $$file ; \
	done
	@for file in $(shell find ./lib -depth 4 -type f -name "*.js") ; do \
		sed -I '' -r -e "s#from '\.\./[\./]*(mjml[^']+)'#from '../../../\1'#g" $$file ; \
	done

# Add .js to all import paths having a /, but NOT beginning with .
	@for file in $(shell find ./lib -type f -name "*.js") ; do \
		sed -I '' -r -e "s#from '([^/]+/[^']+)'#from '\1.js'#g" $$file ; \
	done

# do some general fixes
# note: -e '1h;2,$H;$!d;g' buffers the lines so that multiline regexps works
	@for file in $(shell find ./lib -type f -name "*.js") ; do \
		sed -I '' -r -e "s#from '([^']+)/mjml-core/lib/helpers/#from '\1/mjml-core/helpers/#g" $$file ; \
		sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#import ([^']+) from 'lodash'#import tmp_lodash from 'lodash'\nconst \1 = tmp_lodash#g" $$file ; \
		sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#import ([^']+) from 'lodash/fp.js'#import tmp_lodash_fp from 'lodash/fp.js'\nconst \1 = tmp_lodash_fp#g" $$file ; \
		sed -I '' -r -e "s#module.exports = #export#g" $$file ; \
		sed -I '' -r -e "s#import { minify as htmlMinify } from 'html-minifier'##g" $$file ; \
		sed -I '' -r -e "s#import { html as htmlBeautify } from 'js-beautify'##g" $$file ; \
		sed -I '' -r -e "s#const isNode = require.*#const isNode = false#g" $$file ; \
	done

mjml-replace-specific:
# mjml-core
	@sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#const isNode = false\n\n##g" ./lib/mjml-core/index.js
	@sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#import path from 'path'\n##g" ./lib/mjml-core/index.js
	@sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#import handleMjmlConfig.* from './helpers/mjmlconfig.js'\n\n##g" ./lib/mjml-core/index.js
	@sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#import { minify as htmlMinify } from 'html-minifier'\n\n##g" ./lib/mjml-core/index.js
	@sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#  handleMjmlConfig,\n##g" ./lib/mjml-core/index.js
	@sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#const isNode = false\n\n##g" ./lib/mjml-core/index.js
	@sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#if \(isNode( |\))[^{]+{[^}]+}\n\n##g" ./lib/mjml-core/index.js
	@sed -I '' -r -e "s#[ ]+// if mjmlConfigPath is .*##g" ./lib/mjml-core/index.js
# since [^\n] doesn't work, we start switching \n with @ and then back again after matching
	@sed -I '' -r \
		-e '1h;2,$$H;$$!d;g' \
		-e 's#\n#@#g' \
		-e "s#if \(+(isNode|minify|beautify)( |\))[^{]+{@(    [^@]*@|@){1,}  }@@##g" \
		-e 's#@#\n#g' \
		./lib/mjml-core/index.js

# mjml-parser-xml
	@sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#let cwd = process.cwd\(\)\n\n##g" ./lib/mjml-parser-xml/index.js
	@sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#import path from 'path'\n##g" ./lib/mjml-parser-xml/index.js
	@sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#import fs from 'fs'\n##g" ./lib/mjml-parser-xml/index.js
# since [^\n] doesn't work, we start switching \n with @ and then back again after matching
	@sed -I '' -r \
		-e '1h;2,$$H;$$!d;g' \
		-e 's#\n#@#g' \
		-e "s#if \(+isNode( |\))[^{]+{@(    [^@]*@|@){1,}  }@@##g" \
		-e 's#@#\n#g' \
		./lib/mjml-parser-xml/index.js

# @sed -I '' -r -e '1h;2,$$H;$$!d;g' -e "s#export function readMjmlConfig\(.*\n.*(export function resolveComponentPath\()#\1#g" ./lib/mjml-core/index.js
# @echo ${readMjmlConfig} >> ./lib/mjml-core/index.js

# import handleMjmlConfig, {
# //   readMjmlConfig,
# //   handleMjmlConfigComponents,
# // } from './helpers/mjmlconfig.js'
