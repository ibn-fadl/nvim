-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Auto-open Left Terminal Sidebar",
  callback = function()
    -- Gunakan vim.schedule agar dashboard punya waktu untuk load duluan
    vim.schedule(function()
      -- Cek agar tidak berjalan di git commit atau sesi lazy yang tidak perlu
      if vim.bo.filetype == "gitcommit" or vim.bo.filetype == "lazy" then return end

      -- Simpan ID window utama (Dashboard/File)
      local main_win = vim.api.nvim_get_current_win()

      -- 1. Buat Sidebar Kiri (Window Baru)
      vim.cmd("topleft 40vnew")
      
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

      -- Kembali fokus ke window editing utama (tengah)
      vim.api.nvim_set_current_win(main_win)
    end)
  end,
})
