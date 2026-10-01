return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, c)
        local blend_bg = require("tokyonight.util").blend_bg
        hl.DiffAdd = { bg = blend_bg(c.git.add, 0.3) }
        hl.DiffDelete = { bg = blend_bg(c.git.delete, 0.3) }
        hl.WinSeparator = { fg = c.fg }
        hl.ColorfulWinSep = { fg = c.green }
      end,
    },
  },
}
