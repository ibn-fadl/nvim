-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set
local cmd = vim.cmd

-- Fungsi helper untuk navigasi yang aman (mencegah error jika layout berubah)
local function safe_nav(callback)
  return function()
    local ok, err = pcall(callback)
    if not ok then
      vim.notify("Navigasi Gagal: " .. tostring(err), vim.log.levels.WARN)
    end
  end
end

-- == Terminal Panel Helper Functions ==

local function is_terminal_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local success, is_panel = pcall(vim.api.nvim_win_get_var, win, "is_bottom_terminal")
    if success and is_panel then
      return true
    end
  end
  return false
end

-- Variabel state untuk menyimpan ID buffer terminal
local term_buf = nil

local function open_bottom_terminal()
  local main_win = vim.api.nvim_get_current_win()

  -- 1. Buat Panel Bawah (Split Horizontal)
  vim.cmd("botright 15split")
  vim.api.nvim_win_set_var(0, "is_bottom_terminal", true) -- Tandai window ini

  -- == Terminal ==
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_win_set_buf(0, term_buf)
  else
    vim.cmd("terminal")
    term_buf = vim.api.nvim_get_current_buf()
    vim.bo[term_buf].bufhidden = "hide"
    vim.bo[term_buf].buflisted = false
    vim.bo[term_buf].filetype = "terminal"
  end

  -- Konfigurasi tampilan window
  vim.opt_local.winfixheight = true
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = "no"
  vim.opt_local.foldcolumn = "0"

  if vim.api.nvim_win_is_valid(main_win) then
    vim.api.nvim_set_current_win(main_win)
  end
end

_G.toggle_bottom_terminal = function()
  if is_terminal_open() then
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local success, is_panel = pcall(vim.api.nvim_win_get_var, win, "is_bottom_terminal")
      if success and is_panel then
        vim.api.nvim_win_close(win, true)
      end
    end
  else
    open_bottom_terminal()
  end
end

-- == Window Navigation Customization ==

-- <leader>1: Fokus Terminal Bawah (Auto-Open)
map("n", "<leader>1", safe_nav(function()
  if not is_terminal_open() then
    open_bottom_terminal()
  end
  cmd("wincmd j") -- Pindah ke window di bawah
end), { desc = "Focus Terminal" })

-- <leader>3: Fokus Editor Utama (Atas)
map("n", "<leader>3", safe_nav(function()
  cmd("wincmd k") -- Pindah ke window di atas
end), { desc = "Focus Main Editor" })

-- <leader>4: Fokus File Explorer (Idempotent / No-Toggle)
map("n", "<leader>4", function()
  if not (_G.Snacks and _G.Snacks.picker) then
    vim.notify("Snacks Explorer tidak tersedia.", vim.log.levels.INFO)
    return
  end

  local wins = vim.api.nvim_tabpage_list_wins(0)
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype
    if ft and string.match(ft, "^snacks_picker_") then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  
  _G.Snacks.picker.explorer()
end, { desc = "Focus File Explorer" })

-- == Global Escape Mapping ==

map("n", "<leader>t", function() _G.toggle_bottom_terminal() end, { desc = "Toggle Terminal Panel" })


-- Menggunakan string literal [[...]] untuk menghindari masalah escaping backslash
-- Ini memetakan Ctrl+[ di mode Terminal untuk keluar ke Normal Mode
map("t", "<C-[>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })
