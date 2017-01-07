source /etc/profile

typeset -U path
path=(~/.cabal/bin ~/.cargo/bin ~/.local/bin $path[@])

# vim: ft=zsh
