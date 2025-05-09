packages=(
    # plugins
    yazi-rs/plugins:full-border
    yazi-rs/plugins:git
    # flavours
    yazi-rs/flavors:catppuccin-macchiato
)

echo Installing ${packages[@]}...
ya pack -a ${packages[@]}
