# HexSearch

## Overview
Open the Elixir language Hex documentation website from the command line. Search can be performed with module name and / or function name with arity.

## Installation
I recommend installing Elixir with [asdf](https://asdf-vm.com/#/core-manage-asdf)

Clone the repo. Since these commands are run as mix tasks, no further steps are required, though it is recommended to add a way to call the `mix task(s)` from any directory (see the "Usage" section for more details).

## Usage
Commands are run via a mix task from the base level directory of this repository and can be run in a variety of ways:
* For the hex docs main page:

  ```mix hex_docs```

* For the Kernel / core language module docs: 

  ```mix hex_search```

* To search for a specific module:

  ```mix hex_search <module_name>```

  ie. ```mix hex_search ecto```

  or use the `-m` flag

  ```mix hex_search -m <module_name>```

  ie. ```mix hex_search -m ecto```

* To search for a specific function within a module:

  Place the function name / arity as the next command line argument

  ```mix hex_search <module_name> <function_name/arity>```

  ie. ```mix hex_search ecto assoc/2```

  or use the `-f` flag

  ```mix hex_search <module_name> -f <function_name/arity>```

  ie. ```mix hex_search ecto -f assoc/2```

Commands will work with one "." in the module:
* ie. ```mix hex_search ecto.changeset -f cast/4```

Commands are generally case insensitive with a few exceptions (listed below)

Consider adding a function to your shell setup to allow you to call these `mix task(s)` from anywhere. One way to do this if you are using bash/zsh would be to add a function like this to your .bashrc / .zshrc file:
```
function hex { 
    cd ~/<directory_you_cloned_this_repo_to>/hex_search 
    mix hex_search "$@"
    cd -
}
```
For instance, if this repo was cloned to `~/Code/Elixir/hex_search`:
```
function hex { 
    cd ~/Code/Elixir/hex_search 
    mix hex_search "$@"
    cd -
}
```

## Limitations
* Can only search for modules with one ".". It will fail to parse properly for modules with more than one ".", such as Ecto.Schema.Metadata
* Modules and functions with camel cased titles may not be searchable unless they are entered with the same camel casing from the command line. ie. ```Ecto.ParameterizedType.``` will need to have the "T" in type be entered as an uppercase letter ```mix hex_search ecto.parameterizedType``` Many of the core language modules which are camel cased support case insensitivity on the command line. For further details see `lib/core/elixir_modules.ex` `@core_modules` for supported modules.
* Some core language modules aren't supported for direct lookup. In that instance, it is recommended to manually navigate to the desired module from the main kernel document page.
* Does not support the opening of the core language exception modules directly. 
