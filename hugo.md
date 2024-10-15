# Hugo

Easy way to generate Web and Docs.

Hugo is very useful with Deck and should be integratd early because Hugo provides the Web side and Deck provides the Assets side of things.

It can even be leveraged for the Deck Cloud itself.

## NOTES from hugo plate


    # Preview mode, with nice resizer for Mobile. etvc
	# https://zeon.studio/preview
	# https://zeon.studio/preview?project=hugoplate
	# Perfect because its parmaater drive 
	# url and formfactor is perfect !

	# Speed Check: https://pagespeed.web.dev/analysis/https-zeon-studio-preview/01x9xgqeew?form_factor=mobile
	# The 2 params are here. site is url encoded. Formfactor is querystring


	# BASE URL ..
	# You must replace the baseURL in hugo.toml file when deploying, you can manage this announcement from the params.toml file.

	# Form on Contact page ?
	# Submit goes to: https://localhost/contact/#
	# Its Mail chimp via a gmail... in exampleSite/config/_default/params.toml

	# Author Avatar Images are via 3rd party ?
	# https://github.com/search?q=repo%3Azeon-studio%2Fhugoplate%20email&type=code
	# https://www.gravatar.com/avatar/{{ md5 .Params.email }}?s=128&pg&d=identicon
	# https://www.gravatar.com/avatar/gedw99@gmail.com?s=128&pg&d=identicon
	# NOPE DOES not work,, mhhh

	# Author : https://localhost/authors/
	# Easy to change in the Markdown . i tested it and it works.

	# LANG:

	# Module: github.com/gethugothemes/hugo-modules
	# all there in mono repo :)

## Config

hugo.toml is the standard.



## Roadmap

1. Just get it describing what in the .dep, so that we all dependencies are desribed. 
- I call this hugo-ci, because your using hugo to describe your Continuous Integration

2. All the good stuff i have here: https://github.com/gedw99/gio-htmx/tree/main/exp/hugo
- https://github.com/jhvanderschee/hugobricks
- https://zeon.studio/case-studies. 



## templates

For Professional Persons web sites 
Deck can feed into this for the PDF, or Charts
code: https://github.com/darkweak/cv-hugo
demo: https://xenodochial-newton-16b494.netlify.app

## add ons

https://hugocodex.org/add-ons/