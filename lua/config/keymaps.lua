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

-- == Sidebar Helper Functions ==

local function is_sidebar_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local success, is_sidebar = pcall(vim.api.nvim_win_get_var, win, "is_left_sidebar")
    if success and is_sidebar then
      return true
    end
  end
  return false
end

local function open_left_sidebar()
  local main_win = vim.api.nvim_get_current_win()

  -- 1. Buat Sidebar Kiri (Window Baru) - Lebar ditambah jadi 45
  vim.cmd("topleft 45vnew")
  vim.api.nvim_win_set_var(0, "is_left_sidebar", true) -- Tandai window ini

  -- == Terminal Atas ==
  vim.cmd("terminal")
  vim.bo.buflisted = false
  vim.bo.filetype = "terminal"
  vim.opt_local.winfixwidth = true
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = "no"
  vim.opt_local.foldcolumn = "0"

  -- 2. Split Bawah untuk Terminal Kedua
  vim.cmd("split")
  vim.api.nvim_win_set_var(0, "is_left_sidebar", true) -- Tandai window ini

  -- == Terminal Bawah ==
  vim.cmd("enew") -- Buffer baru terpisah
  vim.cmd("terminal")
  vim.bo.buflisted = false
  vim.bo.filetype = "terminal"
  vim.opt_local.winfixwidth = true
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = "no"
  vim.opt_local.foldcolumn = "0"

  -- Resize Terminal Bawah agar memakan ~70% tinggi layar
  vim.cmd("resize " .. math.floor(vim.o.lines * 0.7))

  -- Kembali fokus ke window editing utama (tengah) - Navigasi spesifik akan override ini nanti
  if vim.api.nvim_win_is_valid(main_win) then
    vim.api.nvim_set_current_win(main_win)
  end
end

_G.toggle_left_sidebar = function()
  if is_sidebar_open() then
    -- Close Sidebar
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local success, is_sidebar = pcall(vim.api.nvim_win_get_var, win, "is_left_sidebar")
      if success and is_sidebar then
        vim.api.nvim_win_close(win, true)
      end
    end
  else
    -- Open Sidebar
    open_left_sidebar()
  end
end


-- == Window Navigation Customization ==

-- <leader>1: Fokus Terminal Bawah (Auto-Open jika tertutup)
-- Logika: Cek sidebar -> Buka jika perlu -> Pindah ke kiri-atas (wincmd t) -> Turun satu (wincmd j)
map("n", "<leader>1", safe_nav(function()
  if not is_sidebar_open() then
    open_left_sidebar()
  end
  cmd("wincmd t")
  cmd("wincmd j")
end), { desc = "Focus Bottom Terminal" })

-- <leader>2: Fokus Terminal Atas (Auto-Open jika tertutup)
-- Logika: Cek sidebar -> Buka jika perlu -> Pindah ke kiri-atas (wincmd t)
map("n", "<leader>2", safe_nav(function()
  if not is_sidebar_open() then
    open_left_sidebar()
  end
  cmd("wincmd t")
end), { desc = "Focus Top Terminal" })

-- <leader>3: Fokus Editor Utama (Tengah)
-- Logika: Pindah ke paling kiri-atas (wincmd t), lalu geser kanan (wincmd l)
map("n", "<leader>3", safe_nav(function()
  cmd("wincmd t")
  cmd("wincmd l")
end), { desc = "Focus Main Editor" })

-- <leader>4: Fokus File Explorer (Idempotent / No-Toggle)
map("n", "<leader>4", function()
  if not (_G.Snacks and _G.Snacks.picker) then
    vim.notify("Snacks Explorer tidak tersedia.", vim.log.levels.INFO)
    return
  end

  -- Cek apakah Explorer sudah terbuka di Tab ini
  local wins = vim.api.nvim_tabpage_list_wins(0)
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype

    -- Deteksi filetype khas Snacks Picker
    if ft and string.match(ft, "^snacks_picker_") then
      -- Jika ketemu, HANYA fokus ke sana (jangan ditutup)
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  -- Jika tidak ada window explorer yang terbuka, baru buka
  Snacks.picker.explorer()
end, { desc = "Focus File Explorer" })

-- == Global Escape Mapping ==

map("n", "<leader>t", function() _G.toggle_left_sidebar() end, { desc = "Toggle Left Sidebar" })

-- Menggunakan string literal [[...]] untuk menghindari masalah escaping backslash
-- Ini memetakan Ctrl+[ di mode Terminal untuk keluar ke Normal Mode
map("t", "<C-[>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })
