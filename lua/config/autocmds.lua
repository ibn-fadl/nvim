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