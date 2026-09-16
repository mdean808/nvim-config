local markdownlint_config = vim.fn.expand("~/.config/markdownlint/.markdownlint-cli2.jsonc")

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
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}
      opts.formatters["markdownlint-cli2"] = opts.formatters["markdownlint-cli2"] or {}
      opts.formatters["markdownlint-cli2"].prepend_args = { "--config", markdownlint_config }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft.markdown = {}
      opts.linters = opts.linters or {}
      opts.linters["markdownlint-cli2"] = { args = { "--config", markdownlint_config, "-" } }
    end,
  },
}
