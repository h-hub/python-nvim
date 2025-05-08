## NeoVim with NvChad for Python Development
Custom config of Nvim (NvChad) as a Python IDE.
Note: This guide takes into account the new configuration structure in NvChad v2.5 and beyond as outlined in the [release notes](https://nvchad.com/news/v2.5_release/).

## Plugins
- **Pyright**: Static type checker and LSP.
- **Black**: Code formatter (automatically runs on save).
- **Ruff**: Linting and code analysis.
- **MyPy**: Static type checker for Python.
- **DebugPy**: Debugger integration.
- **Tree-sitter**: Syntax highlighting and code folding.

### Structure
nvim/ <br>
├── lua/ <br>
│   └── custom/ <br>
│       ├── configs/ <br>
│       │   └── python.lua <br>
│       ├── plugins.lua <br> 
│       └── init.lua <br>

## Pre-requisites
- [NvChad](https://nvchad.com/docs/quickstart/install/#install) (Check if Neovim is up to date (v0.9.5+)!)
  <details>
    <summary>Backup previous Nvim config (optional)</summary>
    
    ```bash
      mv ~/.config/nvim ~/.config/nvim_backup
    ```
    
  </details>
  - Git <br>
  - npm (for installing Pyright) <br>
  - Python (of course)
  
## Installation
```bash
git clone https://github.com/dobval/NvChad-python-config.git ~/.config/nvim/lua
```
Python tools
```bash
pip install black ruff mypy debugpy
```
start *nvim* and sync
```vim
:Lazy sync
```
pyright
```vim
:MasonInstall pyright
```
Tree-sitter
```vim
:TSInstall python
```
### Verify Setup
<details>
  <summary>To make debugging more convenient, the following key mappings are set up:</summary>

- **F5**: Start or continue the debugger.
- **F10**: Step over the current line.
- **F11**: Step into a function.
- **F12**: Step out of a function.
- **\<leader>b**: Toggle a breakpoint.
  </details>
  
  - *Open a Python file* in Neovim.
  - *Check if Pyright is running* by using the command `:LspInfo`.
  - *Save a Python file* to ensure **Black** formats the code.
  - *Check for diagnostics* from **Ruff** and **MyPy**.
  - *Debug a Python file* using the key mappings defined above.
