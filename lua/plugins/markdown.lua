return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      win_options = {
        conceallevel = { rendered = 0, default = 0 },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft.markdown = {}
    end,
  },
}
