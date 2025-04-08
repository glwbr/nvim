<a name="readme-top"></a>

<div align="center">
  <p>A Neovim configuration built with Nix flakes and nixCats</p>
  <p><em>but, I'm a corgi person :dog:</em></p>
  <img src="https://res.cloudinary.com/djb3ju61n/image/upload/v1739062930/corgi_glass.gif" alt="Corgi with glasses" height="300">
</div>

## :thought_balloon: Philosophy

This configuration embraces the power of Nix for dependency management while maintaining the flexibility of Lua for Neovim configuration. While projects like nixvim offer a complete Nix-based approach, nixCats provides an excellent middle ground - allowing us to:

- Manage dependencies efficiently with Nix
- Keep our existing Lua configurations
- Avoid the need to refactor everything into Nix expressions

The goal is to maintain a minimal yet fully functional setup that prioritizes simplicity without sacrificing capabilities.

## :sparkles: Features

- Built using nixCats and Nix flakes
- Pure Lua configuration
- Simple dependency management
- Compatibility with standard Neovim configurations with lazy.nvim

## :rocket: Quick Start

Run this configuration directly using:

```nix
nix run "https://github.com/glwbr/nvim"
```

## :arrows_counterclockwise: Project Status

This configuration is actively maintained and evolving. While it's already functional for daily use, I'm constantly learning and making improvements. Contributions and suggestions are welcome!

## :heart: Acknowledgments

Special thanks to [BirdeeHub](https://github.com/BirdeeHub) for creating nixCats, which makes this approach possible.

## :handshake: Contributing

Feel free to share your ideas and feedback

<!-- IMAGES -->
[corgi_glass]: "https://res.cloudinary.com/djb3ju61n/image/upload/v1739062930/corgi_glass.gif"
