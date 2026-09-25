local unignored = {
  fd = { ".env", ".env.*", ".scratch", "CLAUDE.md", "docs" },
  rg = { ".env", ".env.*", "**/.scratch/**", "CLAUDE.md", "**/docs/**" },
}

local heavy_dirs = { ".git", "node_modules", ".venv", "target", "build", "dist" }

local function rg_globs(globs, prefix)
  return vim.tbl_map(function(glob)
    return (prefix or "") .. glob
  end, globs)
end

local function rg_glob_args(globs, prefix)
  local args = {}
  for _, glob in ipairs(rg_globs(globs, prefix)) do
    vim.list_extend(args, { "-g", glob })
  end
  return args
end

local function finder(source, overrides)
  return function(opts, ctx)
    return require("snacks.picker.source." .. source)[source](
      setmetatable(vim.deepcopy(overrides), { __index = opts }),
      ctx
    )
  end
end

local function unignored_glob_args()
  return vim.list_extend(rg_glob_args(heavy_dirs, "!"), rg_glob_args(unignored.rg))
end

local function unignored_globs()
  return vim.list_extend(rg_globs(heavy_dirs, "!"), rg_globs(unignored.rg))
end

return {
  {
    "snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = false,
            finder = {
              finder("files", { exclude = unignored.fd }),
              finder("files", {
                cmd = "rg",
                ignored = true,
                args = unignored_glob_args(),
              }),
            },
          },
          grep = {
            hidden = true,
            ignored = false,
            finder = {
              finder("grep", { glob = vim.list_extend(rg_globs(heavy_dirs, "!"), rg_globs(unignored.rg, "!")) }),
              finder("grep", { ignored = true, glob = unignored_globs() }),
            },
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
