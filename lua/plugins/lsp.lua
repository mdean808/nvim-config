return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          -- stylua: ignore
          keys = {
            { "gd", function() Snacks.picker.lsp_references() end, desc = "Peek references" },
            { "gD", function() Snacks.picker.lsp_definitions() end, desc = "Goto definition" },
          },
        },

        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard",
              },
            },
          },
        },

        oxfmt = { enabled = false },
      },
    },
  },
}
