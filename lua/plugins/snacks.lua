return {
  {
    "snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = false,
          },
          grep = {
            hidden = true,
            ignored = false,
          },
          select = {
            layout = { border = "rounded" },
            kinds = {
              codeaction = {
                on_show = function()
                  vim.cmd.stopinsert()
                end,
              },
            },
          },
        },
        win = {
          input = { border = "rounded" },
          list = { border = "rounded" },
          preview = { border = "rounded" },
        },
      },
    },
  },
}
