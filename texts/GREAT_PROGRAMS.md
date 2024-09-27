## Prerequisites

install cargo-binstall for quicker installation. `cargo binstall cargo-binstall`

| link                                           | install command                  |
| ---------------------------------------------- | -------------------------------- |
| <https://github.com/marcusbuffett/pipe-rename> | `cargo binstall pipe-rename`     |
| <https://github.com/unfrl/dug>                 | `cargo binstall dug`            |
| <https://github.com/ajeetdsouza/zoxide>        | `cargo binstall zoxide --locked` |
| <https://github.com/theryangeary/choose>       | `cargo binstall choose`          |
| <https://github.com/junegunn/fzf>              | `cargo binstall fzf`             |
| <https://github.com/sharkdp/bat>               | `cargo binstall bat`             |
| <https://github.com/theryangeary/choose>       | `cargo binstall choose`          |
| <https://github.com/ducaale/xh>                | `cargo binstall xh`              |
| <https://github.com/Peltoche/lsd>              | `cargo binstall lsd`             |
| <https://starship.rs/>                         | `cargo binstall starship`        |

## fzf

### powershell

open multiple files interactively.
`vim (fzf -m)`, use `shift-tab` to select.

## zoxide

`z path`, once it has been used more than once it remembers the path, and you can enter `z foo`, foo being just a small part of path.
`zi path`, opens interactively with fzf.

## httpie OR xh

xh is httpie clone in rust
`http https://dummyjson.com/products/add cost=10` - post request
`http https://dummyjson.com/users` - get request

## starship

remeber to add to script file.
`Invoke-Expression (&starship init powershell) >> $PROFILE`

## Favourites

zoxide, lsd, xh, fzf, starship
