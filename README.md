# Zsh & Neovim Dotfiles

A clean, portable zsh configuration with no external dependencies (except optional enhancements), plus a high-quality Neovim setup with minimap and QOL features.

## Features

### Zsh Configuration
- **Git-aware prompt** with status indicators (✔, ✘, !, ?)
- **Better history management** with 10,000 entries
- **Useful aliases** for common commands
- **Utility functions** for better terminal output
- **Modular configuration** structure
- **Optional terminal enhancements** via Homebrew

### Neovim Configuration
- **Minimap** with codewindow.nvim for code overview
- **Lazy.nvim** plugin manager for fast startup
- **Tokyo Night** colorscheme
- **Telescope** fuzzy finder for files, buffers, and more
- **Treesitter** syntax highlighting and parsing
- **LSP** support with auto-completion
- **Git integration** with gitsigns
- **File explorer** with nvim-tree
- **Status line** with lualine
- **Buffer management** with bufferline
- **Auto-pairs** and smart commenting

## Quick Setup

### Zsh Configuration

1. **Install the zsh configuration:**
   ```bash
   ./install.sh
   ```

2. **Reload your shell:**
   ```bash
   source ~/.zshrc
   ```

3. **Optional: Install terminal enhancement tools:**
   ```bash
   setup-terminal
   ```

### Neovim Configuration

1. **Install Neovim (if not already installed):**
   ```bash
   brew install neovim
   ```

2. **Install the Neovim configuration:**
   ```bash
   ./install-nvim.sh
   ```

3. **Open Neovim and wait for plugins to install:**
   ```bash
   nvim
   ```

4. **Restart Neovim to ensure everything is loaded properly**

## What's Included

### Core Configuration
- History settings (10k entries, ignore duplicates, share history)
- Completion system
- Terminal title management
- Modular config loading from `~/.config/zsh/*.zsh`

### Aliases
- `ls`, `grep`, `diff` with colors
- `cat` → `bat` (better syntax highlighting)
- `less` → `bat` with paging
- Git shortcuts: `glog`, `gstatus`, `gdiff`
- Directory listing: `ll`, `la`

### Utility Functions
- `logview()` - Colorized log viewing
- `json()` - Pretty JSON formatting
- `tailcolor()` - Colored log tailing
- `search()` - Context-aware file searching

### Git-Aware Prompt
- Shows current git branch and status
- Visual indicators for:
  - ✔ Staged changes
  - ✘ Deleted files
  - ! Modified files
  - ? Untracked files
- Smart path display (shows repo name + relative path)

### Neovim Key Mappings

**Leader key:** `<space>` (most mappings start with `<leader>`)

- `<leader>mm` - Toggle minimap
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>e` - Toggle file explorer
- `<leader>f` - Format code
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>d` - Show diagnostics
- `<leader>h` - Clear search highlighting

**Navigation:**
- `<C-h/j/k/l>` - Navigate between windows
- `<C-Up/Down/Left/Right>` - Resize windows
- `<A-j/k>` - Move lines up/down
- `]d/[d` - Next/previous diagnostic
- `]q/[q` - Next/previous quickfix
- `]l/[l` - Next/previous location

**General:**
- `jk` or `kj` - Escape from insert mode
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>x` - Save and quit
- `<leader>t` - Open terminal

## Optional Enhancements

The `setup-terminal` command installs:
- **bat** - Better cat with syntax highlighting
- **jq** - JSON processor with color
- **git-delta** - Better git diffs
- **glow** - Markdown renderer
- **ripgrep** - Faster grep
- **zsh-autosuggestions** - Command suggestions
- **zsh-syntax-highlighting** - Syntax highlighting

## File Structure

```
.zshrc                    # Main zsh configuration
.config/
  zsh/
    base.zsh             # Git prompt and additional config
nvim-config/              # Neovim configuration
  init.lua               # Main Neovim config
  core/                  # Core settings
    options.lua          # Neovim options
    keymaps.lua          # Key mappings
    autocmds.lua         # Auto commands
  plugins/               # Plugin configurations
    init.lua             # Plugin specifications
    minimap.lua          # Minimap config
    telescope.lua        # Telescope config
    treesitter.lua       # Treesitter config
    lsp/                 # LSP configurations
    ui/                  # UI plugin configs
    editing/             # Editing plugin configs
    git/                 # Git plugin configs
install.sh               # Zsh installation script
install-nvim.sh          # Neovim installation script
```

## Customization

Add your own configuration files to `~/.config/zsh/` with `.zsh` extension. They'll be automatically loaded by the main `.zshrc`.

## Backup

The installation script automatically backs up your existing `.zshrc` to `.zshrc.backup` before installing.

## Requirements

- zsh shell
- macOS (for Homebrew-based enhancements)
- Git (for git-aware features)
- Neovim 0.8+ (for Neovim configuration)
- Homebrew (for installing Neovim)

## License

See [LICENSE](LICENSE) file for details. 