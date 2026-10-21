local max_branch_length = 25

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_b = {
        {
          "branch",
          fmt = function(branch)
            if vim.fn.strchars(branch) <= max_branch_length then
              return branch
            end
            return vim.fn.strcharpart(branch, 0, max_branch_length) .. "…"
          end,
        },
      }
      opts.sections.lualine_z = {}
    end,
  },
}
