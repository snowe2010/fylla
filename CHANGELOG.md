# 0.5.1

* Fix completions for string enums, only complete a single arg, rather than multiple
args.

* Don't put = when option is a boolean
 
# 0.5.0

Move `completion:` option into a new `fylla:` hash option to allow for expanding the 
features of fylla. 

Modify the `zsh_completion` feature to generate completion for `enum:` options. 
  
  * By default it will remove duplicate matches when completing
  
Add new `filter:` option into `fylla:` in order to allow _not_ removing duplicate 
matches when completing `enum:` options

# 0.4.3

Fix null descriptions causing parsing failures 2.0 (`\` didn't work, trying `'"'"'`)

# 0.4.2

Fix null descriptions causing parsing failures

# 0.4.1

Small bug when the descriptions contain single or double quotes (in zsh)

# 0.4.0

Add `completion:` option for `option` hash. Specify this if 
`desc` or `banner` are not providing desired completion text

# 0.2.0

* add bash completion generation
* add code coverage metrics

# 0.1.0

Initial version of Fylla

* add zsh completion generation
* add zsh tests
* add rubocop formatting
* add yard documentation 
