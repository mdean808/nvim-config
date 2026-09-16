local function show_unignored_undimmed()
  local components = require("neo-tree.sources.common.components")
  local filtered_by = components.filtered_by
  components.filtered_by = function(config, node, state)
    local fby = node.filtered_by
    if type(fby) == "table" and fby.always_show then
      return {}
    end
    return filtered_by(config, node, state)
  end
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      show_unignored_undimmed()
      return vim.tbl_deep_extend("force", opts, {
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = true,
            hide_by_name = {
              ".DS_Store",
              "thumbs.db",
            },
            always_show = {
              "CLAUDE.md",
              ".scratch",
              "docs",
            },
            always_show_by_pattern = {
              ".env*",
              "*/.scratch/*",
              "*/docs/*",
            },
          },
        },
      })
    end,
  },
}
