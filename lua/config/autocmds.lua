-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`

-- Ensure Snacks Explorer is closed on startup (prevents session restore from keeping it open)
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Close Snacks Explorer on Startup",
  callback = function()
    vim.schedule(function()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype
        if ft and string.match(ft, "^snacks_picker_") then
          vim.api.nvim_win_close(win, true)
        end
      end
    end)
  end,
})

-- FIX KURSOR MERAH (Prioritas Utama)
-- Memaksa highlight cursor setiap kali colorscheme dimuat/diubah
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local red_cursor = { bg = "#FF0000", fg = "#000000" }
    vim.api.nvim_set_hl(0, "Cursor", red_cursor)
    vim.api.nvim_set_hl(0, "TermCursor", red_cursor)
    vim.api.nvim_set_hl(0, "CursorNC", red_cursor)
    -- Tambahan untuk mode Insert (seringkali di-handle terpisah oleh terminal emulator/GUI)
    vim.api.nvim_set_hl(0, "lCursor", red_cursor)
    vim.api.nvim_set_hl(0, "CursorIM", red_cursor)
  end,
})

-- Explicitly ensure Normal highlight group has no blend
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- These colors are based on the tokyonight.nvim configuration in lua/plugins/theme.lua
    local bg_color = "#16161e" -- main_bg
    local fg_color = "#d4d6c6" -- colors.fg
    vim.api.nvim_set_hl(0, "Normal", { bg = bg_color, fg = fg_color, blend = 0 })
    -- vim.api.nvim_set_hl(0, "NormalNC", { bg = bg_color, blend = 0 }) -- Removed redundant setting
    vim.api.nvim_set_hl(0, "SignColumn", { bg = bg_color }) -- Set SignColumn to the same background

    -- Floating Windows & Popups
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg_color })
    vim.api.nvim_set_hl(0, "Pmenu", { bg = bg_color })

    -- Telescope Specific Overrides
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = bg_color })
    vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = bg_color })
    vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = bg_color })
    vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = bg_color })
  end,
  desc = "Ensure Normal highlight group has no blend",
})

-- Ensure main windows are always opaque (winblend = 0)
vim.api.nvim_create_autocmd({ "WinNew", "WinClosed", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("ForceOpaqueMainWindows", { clear = true }),
  callback = function()
    for _, winid in ipairs(vim.api.nvim_list_wins()) do
      local buftype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winid), "buftype")
      local is_float = vim.api.nvim_win_get_config(winid).float

      -- Only set winblend for normal buffer windows, not floating windows
      if buftype == "" and not is_float then
        vim.api.nvim_win_set_option(winid, "winblend", 0)
      end
    end
  end,
  desc = "Ensure main editor windows remain opaque",
})