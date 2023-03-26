# Installation

Run the command below in your terminal

> $ git clone git://github.com/ktact/dotfiles  
> $ cd dotfiles  
> $ ./setup.sh  

# Packages to be installed
* [Docker Engine](https://docs.docker.jp/get-started/overview.html)
* [fzf](https://github.com/junegunn/fzf)
* [Deno](https://github.com/denoland/deno)

# Aliases to be set
* `docker-purge`  
  Force removal of all container images.  
  (`docker stop $(docker ps -q -a) && docker container prune && docker rmi $(docker images -q) -f`)
* `fgv`  
  Use the fuzzy finder to select the file from the search results by grep and open it.  
  (`grep -Rn '$1' . 2>/dev/null | fzf | awk -F ":" '{ print $1 " +" $2 }' | vi`)

# Vim Settings
## Shortcuts
|Shortcut Keys|Description|
|---|---|
|`Ctrl+]`|`:LspDefinition`|
|`]+w`|`LspNextWarning`|
|`[+w`|`LspPreviousWarning`|
|`]+e`|`LspNextError`|
|`[+e`|`LspPreviousError`|

see [here](https://github.com/prabirshrestha/vim-lsp#supported-commands) for [vim-lsp](https://github.com/prabirshrestha/vim-lsp) supported commands.
