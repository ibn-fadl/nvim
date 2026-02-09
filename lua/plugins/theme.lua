return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = false,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },

      on_colors = function(colors)
        local main_bg = "#000000"
        local pop_bg  = "#000000"

        colors.bg = main_bg
        colors.bg_sidebar = main_bg
        colors.bg_dark = pop_bg
        colors.bg_float = pop_bg
        colors.bg_popup = pop_bg
        colors.border = "#ffffff"
        colors.fg = "#d4d6c6"
      end,

      on_highlights = function(hl, colors)
        local c = {
          base      = "#000000",
          black     = "#000000",
          text      = "#d4d6c6",
          white     = "#ffffff",

          -- COLOR CONFIG:
          pink_bright = "#f30974",
          pink_dark   = "#ab0652",

          -- [BARU] PINK SAGE / DUSTY PINK
          -- Kode ini jauh lebih desaturated (keabu-abuan) dan soft.
          -- Tidak lagi neon ("menyala").
          pink_sage   = "#523646",

          green_lime  = "#bae67e",
          yellow_gold = "#ffd602",
          blue      = "#1ea8fc",
          purple    = "#d699ff",
          cyan      = "#80e5ff",
          pale      = "#cebbfa",
          grey      = "#505050",
          cursor    = "#FF0000",
          silver    = "#C0C0C0",
        }

        local function set(groups, opts)
          for _, group in ipairs(groups) do hl[group] = opts end
        end

        -- === BAGIAN 1: SYNTAX HIGHLIGHTING ===
        set({
          "Keyword", "Statement", "Conditional", "Repeat", "Include",
          "Structure", "Define", "PreProc", "Exception",
          "@keyword", "@keyword.function", "@keyword.import", "@include"
        }, { fg = c.blue, italic = false })

        set({
          "Function", "@function", "@function.call", "@method", "@constructor",
          "Title",
          "@lsp.typemod.namespace.declaration",
        }, { fg = c.white, bold = false })

        set({ "@module", "@namespace", "@lsp.type.namespace" }, { fg = c.green_lime })

        set({
          "Type", "@type.builtin", "@lsp.type.builtinType",
          "@lsp.typemod.type.defaultLibrary", "@lsp.typemod.builtin.defaultLibrary",
        }, { fg = c.pink_dark, italic = true })

        set({
          "@type", "@type.definition", "@lsp.type.struct", "@lsp.type.interface",
          "@lsp.type.enum", "@lsp.type.type", "Structure",
        }, { fg = c.pink_bright })

        set({
          "Identifier", "@variable", "@variable.parameter",
          "@field", "@property", "@variable.member",
          "@lsp.type.property", "@lsp.type.variable", "@lsp.type.parameter"
        }, { fg = c.white })

        set({ "Operator", "@operator", "Delimiter", "@punctuation.delimiter" }, { fg = c.white })
        set({ "@punctuation.bracket" }, { fg = c.white })
        set({ "String", "Character" }, { fg = c.silver })
        set({ "Constant", "@constant.builtin" }, { fg = c.pale })


        -- === BAGIAN 2: USER INTERFACE ===
        set({
          "Normal", "NormalNC", "Terminal", "TermNormal",
          "NeoTreeNormal", "NeoTreeNormalNC", "SideBar", "SideBarNC",
          "SnacksNormal", "SnacksNormalNC",
          "SnacksPickerNormal", "SnacksPickerNormalNC",
          "SnacksPickerList", "SnacksPickerPreview", "SnacksLayoutNormal",
          "SnacksDashboardNormal", "SnacksTerminal", "SnacksTerminalNormal",
          "TelescopeNormal", "TelescopeBorder"
        }, { bg = c.base })

        set({
          "Floaterm", "NormalFloat",
          "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb"
        }, { bg = c.black })

        set({
          "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator"
        }, { fg = c.base, bg = c.base })

        hl.FloatermBorder = { bg = c.black, fg = colors.border }
        hl.LineNr = { fg = c.grey }
        hl.CursorLineNr = { fg = c.white, bold = true }
        hl.Cursor = { bg = c.cursor, fg = c.black }


        -- === BAGIAN 3: DASHBOARD ===
        set({
            "DashboardHeader", "DashboardCenter", "DashboardFooter",
            "DashboardShortCut", "DashboardIcon", "DashboardKey", "DashboardDesc",
            "SnacksDashboardHeader", "SnacksDashboardIcon", "SnacksDashboardKey",
            "SnacksDashboardDesc", "SnacksDashboardDir", "SnacksDashboardFile",
            "SnacksDashboardFooter", "SnacksDashboardSpecial",
        }, { fg = c.white })


        -- === BAGIAN 4: VISUAL SELECTION (PINK SAGE) ===
        -- Menggunakan warna #523646 (Muted Dusty Pink)
        hl.Visual = { bg = c.pink_sage, fg = c.white }

        -- Warna seleksi saat tidak aktif (lebih gelap lagi)
        hl.VisualNOS = { bg = "#33222c", fg = c.grey }
      end,
    },
  },

  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
}
