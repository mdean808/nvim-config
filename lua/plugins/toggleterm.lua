return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return math.floor(vim.o.lines * 0.3)
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
      direction = "horizontal",
      start_in_insert = true,
      insert_mappings = false,
      terminal_mappings = false,
      persist_size = true,
      close_on_exit = true,
      shell = vim.o.shell,
    },
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle terminal" },
      { "<leader>tf", "<cmd>TermSelect<cr>", desc = "Select terminal" },
      {
        "<leader>_",
        function()
          local terms = require("toggleterm.terminal").get_all()
          local next_id = #terms + 1
          vim.cmd(next_id .. "ToggleTerm direction=vertical")
        end,
        mode = { "n", "t" },
        ft = "toggleterm",
        desc = "Split vertical (new terminal)",
      },
      {
        "<leader>|",
        function()
          local terms = require("toggleterm.terminal").get_all()
          local next_id = #terms + 1
          vim.cmd(next_id .. "ToggleTerm direction=horizontal")
        end,
        mode = { "n", "t" },
        ft = "toggleterm",
        desc = "Split horizontal (new terminal)",
      },
      { "<leader>tt", "<cmd>ToggleTerm<cr>", mode = "t", desc = "Toggle terminal" },
      { "<C-h>", "<cmd>wincmd h<cr>", mode = "t", desc = "Move to left window" },
      { "<C-j>", "<cmd>wincmd j<cr>", mode = "t", desc = "Move to window below" },
      { "<C-k>", "<cmd>wincmd k<cr>", mode = "t", desc = "Move to window above" },
      { "<C-l>", "<cmd>wincmd l<cr>", mode = "t", desc = "Move to right window" },
      { "<Esc><Esc>", "<C-\\><C-n>", mode = "t", desc = "Exit terminal mode" },
    },
  },
}
