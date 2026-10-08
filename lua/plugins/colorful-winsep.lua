local junctions = {
  udlr = "┼",
  udl = "┤",
  udr = "├",
  ulr = "┴",
  dlr = "┬",
  dl = "┐",
  dr = "┌",
  ul = "┘",
  ur = "└",
}

local function tiled_window_rects()
  local rects = {}
  for _, info in ipairs(vim.fn.getwininfo()) do
    if info.tabnr == vim.fn.tabpagenr() and vim.api.nvim_win_get_config(info.winid).relative == "" then
      table.insert(rects, {
        row = info.winrow - 1,
        col = info.wincol - 1,
        height = info.height + info.winbar,
        width = info.width,
      })
    end
  end
  return rects
end

local function junction_finder(rects)
  local top, bottom = math.huge, 0
  for _, rect in ipairs(rects) do
    top = math.min(top, rect.row)
    bottom = math.max(bottom, rect.row + rect.height)
  end

  local function is_separator(row, col)
    if row < top or row >= bottom or col < 0 or col >= vim.o.columns then
      return false
    end
    for _, rect in ipairs(rects) do
      if row >= rect.row and row < rect.row + rect.height and col >= rect.col and col < rect.col + rect.width then
        return false
      end
    end
    return true
  end

  return function(row, col, fallback)
    local key = (is_separator(row - 1, col) and "u" or "")
      .. (is_separator(row + 1, col) and "d" or "")
      .. (is_separator(row, col - 1) and "l" or "")
      .. (is_separator(row, col + 1) and "r" or "")
    return junctions[key] or fallback
  end
end

local function draw_junctions(separator, junction_at)
  if not (separator._show and separator.winid and vim.api.nvim_win_is_valid(separator.winid)) then
    return
  end
  local row, col = unpack(vim.api.nvim_win_get_position(separator.winid))
  local lines = vim.api.nvim_buf_get_lines(separator.buffer, 0, -1, false)

  if #lines > 1 then
    for i, char in ipairs(lines) do
      lines[i] = junction_at(row + i - 1, col, char)
    end
  else
    local chars = vim.fn.split(lines[1], "\\zs")
    for i, char in ipairs(chars) do
      chars[i] = junction_at(row, col + i - 1, char)
    end
    lines = { table.concat(chars) }
  end

  vim.api.nvim_buf_set_lines(separator.buffer, 0, -1, false, lines)
end

return {
  {
    "nvim-zh/colorful-winsep.nvim",
    event = { "WinLeave" },
    opts = {
      border = "single",
      animate = { enabled = false },
      indicator_for_2wins = { position = false },
    },
    config = function(_, opts)
      require("colorful-winsep").setup(opts)

      local view = require("colorful-winsep.view")
      local render = view.render

      view.render = function()
        render()
        local junction_at = junction_finder(tiled_window_rects())
        for _, separator in pairs(view.separators) do
          draw_junctions(separator, junction_at)
        end
      end
    end,
  },
}
