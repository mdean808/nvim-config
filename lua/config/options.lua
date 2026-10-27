vim.g.lazyvim_python_lsp = "basedpyright"

vim.diagnostic.config({
  float = { border = "rounded" },
})

vim.opt.conceallevel = 0

local function linked_scratch_root(buf)
  local repos = vim.fn.expand("~/.scratch/repos/")
  local repo = vim.api.nvim_buf_get_name(buf):match("^" .. vim.pesc(repos) .. "([^/]+)/")
  if not repo then
    return {}
  end
  local cwd = vim.uv.cwd()
  for _, name in ipairs({ ".scratch", ".local", "CLAUDE.local.md" }) do
    local target = vim.uv.fs_readlink(cwd .. "/" .. name)
    if target and vim.startswith(target, repos .. repo .. "/") then
      return { cwd }
    end
  end
  return {}
end

vim.g.root_spec = { linked_scratch_root, "lsp", { ".git", "lua" }, "cwd" }

if vim.env.TMUX then
  vim.g.clipboard = "osc52"
  vim.opt.clipboard = "unnamedplus"
end
