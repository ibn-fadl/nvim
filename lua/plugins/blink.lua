return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        -- Mengaktifkan ghost text (teks bayangan)
        ghost_text = {
          enabled = true,
        },
        -- Opsi list: agar menu muncul otomatis atau manual
        list = {
          selection = {
            preselect = false, -- Jangan pilih otomatis item pertama (biar ghost text lebih dominan visualnya)
            auto_insert = true, -- Insert text saat navigasi
          },
        },
      },
      -- Konfigurasi Keymap
      keymap = {
        preset = "none", -- Kita set manual agar 'persis' keinginan user

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },

        -- LOGIKA TAB SEPERTI VS CODE / COPILOT:
        -- 1. Jika menu terbuka -> Tab menerima (select_and_accept)
        -- 2. Jika tidak -> Tab indentasi biasa (fallback)
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
    },
  },
}
