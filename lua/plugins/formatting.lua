local biome_fts = {
  "css",
  "graphql",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "svelte",
  "typescript",
  "typescriptreact",
  "vue",
}

local function has_biome_config(ctx)
  return vim.fs.root(ctx.buf, { "biome.json", "biome.jsonc" }) ~= nil
end

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(biome_fts) do
        local list = opts.formatters_by_ft[ft] or {}
        if not vim.tbl_contains(list, "biome") then
          table.insert(list, 1, "biome")
        end
        opts.formatters_by_ft[ft] = list
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.biome = vim.tbl_deep_extend("force", opts.formatters.biome or {}, {
        condition = function(_, ctx)
          return has_biome_config(ctx)
        end,
      })

      local prettier = opts.formatters.prettier or {}
      local base = prettier.condition
      opts.formatters.prettier = vim.tbl_deep_extend("force", prettier, {
        condition = function(self, ctx)
          if has_biome_config(ctx) then
            return false
          end
          return base == nil or base(self, ctx)
        end,
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "biome" } },
  },
}
