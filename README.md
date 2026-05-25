<a name="readme-top"></a>

<div align="center">
  <p>A Neovim configuration</p>
  <p><em>but, I'm a corgi person :dog:</em></p>
  <img src="https://res.cloudinary.com/djb3ju61n/image/upload/v1739062930/corgi_glass.gif" alt="Corgi with glasses" height="300">
</div>

## Requirements

- **Neovim 0.12+**
- **git**
- **tree-sitter-cli** — required by nvim-treesitter to compile parsers
- **node**, **go**, and other runtimes as needed by the LSP servers and linters you use

## Installation

**1. Clone**

```sh
git clone https://github.com/glwbr/nvim ~/.config/nvim
```

**2. Install tree-sitter-cli**

```sh
curl -L "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz" \
  | gunzip -c > ~/.local/bin/tree-sitter
chmod +x ~/.local/bin/tree-sitter
```

Make sure `~/.local/bin` is in your `PATH`.

**3. Open Neovim**

```sh
nvim
```

lazy.nvim will bootstrap itself and install all plugins on first launch. Mason will install LSP servers, formatters, and linters automatically.

## Plugin management

Plugins are locked to specific commits via `lazy-lock.json`. To update:

```
:Lazy update
```

To restore pinned versions after cloning:

```
:Lazy restore
```

## Contributing

Feel free to share ideas and feedback.

<!-- IMAGES -->
[corgi_glass]: "https://res.cloudinary.com/djb3ju61n/image/upload/v1739062930/corgi_glass.gif"
