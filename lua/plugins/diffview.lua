return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewRefresh" },
    opts = {
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_win_enter = function(_, winid)
          vim.wo[winid].number = false
          vim.wo[winid].relativenumber = false
        end,
      },
      keymaps = {
        view = {
          ["<leader>e"] = "<Cmd>DiffviewToggleFiles<CR>",
          ["<leader>b"] = false,
        },
        file_panel = {
          ["<leader>e"] = "<Cmd>DiffviewToggleFiles<CR>",
          ["<leader>b"] = false,
        },
        file_history_panel = {
          ["<leader>e"] = "<Cmd>DiffviewToggleFiles<CR>",
          ["<leader>b"] = false,
        },
      },
      view = {
        merge_tool = { layout = "diff3_mixed" },
      },
    },
    keys = {
      {
        "<leader>gd",
        function()
          if require("diffview.lib").get_current_view() then
            vim.cmd("DiffviewClose")
          else
            vim.cmd("DiffviewOpen")
          end
        end,
        desc = "Diffview (uncommitted vs HEAD)",
      },
    },
  },
  {
    "snacks.nvim",
    keys = function(_, keys)
      return vim.tbl_filter(function(key)
        return key[1] ~= "<leader>gd"
      end, keys)
    end,
  },
}
