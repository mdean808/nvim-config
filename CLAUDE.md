# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a LazyVim-based Neovim configuration. LazyVim is a Neovim setup powered by lazy.nvim that provides sensible defaults with extensive customization options.

## Code Formatting

Lua files use StyLua with these settings (see `stylua.toml`):
- 2-space indentation
- 120 character line width

Format Lua files: `stylua lua/`

## Architecture

```
init.lua              → Entry point, loads config.lazy
lua/
  config/
    lazy.lua          → lazy.nvim bootstrap and plugin spec loading
    options.lua       → Vim options (extends LazyVim defaults)
    keymaps.lua       → Custom keybindings (loaded on VeryLazy event)
    autocmds.lua      → Custom autocommands (loaded on VeryLazy event)
  plugins/            → Plugin specs (all .lua files auto-loaded by lazy.nvim)
lazyvim.json          → Enabled LazyVim extras
```

## Plugin Configuration Patterns

Plugin files in `lua/plugins/` use lazy.nvim spec format:
- Return a table of plugin specs
- Override LazyVim plugins by specifying the same plugin name with `opts`
- Disable plugins with `enabled = false`
- Use `opts` function to merge/extend default options

Example extending opts:
```lua
return {
  {
    "plugin/name",
    opts = function(_, opts)
      -- modify opts table
    end,
  },
}
```

## Enabled LazyVim Extras

Extras configured in `lazyvim.json`:
- Languages: TypeScript, Svelte, Vue, Python, Rust, Docker, Terraform, SQL, JSON, YAML, Markdown, Git, Tailwind
- Formatting: Prettier
- Linting: ESLint
- Editor: neo-tree, dial
- Util: dot, mini-hipatterns

Biome is not a LazyVim extra. `lua/plugins/formatting.lua` registers it with
conform and gates it behind the presence of a `biome.json`.

## Custom Keymaps (lua/config/keymaps.lua)

Notable remappings from LazyVim defaults:
- `jk` → Exit insert mode
- `gt`/`gT` → Buffer navigation (not tab navigation)
- `<leader>o` → File picker (Snacks)
- `<leader>i` → Code actions
- `<leader>r` → Rename symbol
- `<leader>x` → Remove buffer (this shadows LazyVim's `<leader>x` Trouble prefix)
- `gd` → Peek references (not go to definition)
- `gD` → Go to definition, except in TS/JS where LazyVim's vtsls config binds it
  to `typescript.goToSourceDefinition`

`gd` and `gD` live in `lua/plugins/lsp.lua` under `servers["*"].keys`, not in
`keymaps.lua`. LazyVim sets its LSP keymaps per-buffer on LspAttach, and a
buffer-local mapping beats a global one.

## Custom Plugin Modifications

- **blink.cmp**: Enter preset with Tab to select_and_accept, C-j/C-k for navigation
- **mini.surround**: cs-prefixed mappings (csa=add, csd=delete, cs=replace)
- **snacks.nvim**: Explorer disabled, using neo-tree instead
- **gitsigns**: current-line blame on, 1000ms delay. Each blame is a `git blame`
  subprocess, so a shorter delay stutters in large repos.

## LSP servers

mason-lspconfig auto-enables every server installed in mason, whether a LazyVim
extra configures it or not. A server that shows up unwanted gets switched off
with `<name> = { enabled = false }` in `lua/plugins/lsp.lua`. That is why `oxfmt`
is disabled there: it is a formatter, and it was attaching to JS/TS/Svelte
buffers and advertising formatting.

basedpyright runs in `standard` mode. Its own default is `recommended`, which
reports every `Any`, unknown member type and missing stub as an error.
