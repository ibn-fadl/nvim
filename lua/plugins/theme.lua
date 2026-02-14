return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = false,
      dim_inactive = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },

      on_colors = function(colors)
        local main_bg = "#010101"
        local pop_bg  = "#010101"
        local main_border_color = "#E0E0E0" -- Define local literal for border

        colors.bg = main_bg
        colors.bg_sidebar = main_bg
        colors.bg_dark = pop_bg


        colors.border = main_border_color -- Use local literal
        colors.fg = "#d4d6c6"
      end,

      on_highlights = function(hl, colors)
        local c = {
          base      = "#010101",
          black     = "#010101",
          text      = "#d4d6c6",
          white     = "#E0E0E0",

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
          cyan_blue = "#2cc3df",

          package_color = "#FFFFFF",
          string_color  = "#7aa2f7",
          darker_silver = "#B0B0B0",
        }

        local function set(groups, opts)
          for _, group in ipairs(groups) do hl[group] = opts end
        end

        -- === BAGIAN 1: SYNTAX HIGHLIGHTING ===
        set({
          "Keyword", "Statement", "Conditional", "Repeat", "Include",
          "Structure", "Define", "PreProc", "Exception",
          "@keyword", "@keyword.function", "@keyword.import", "@include"
        }, { fg = c.grey, italic = false })

        set({
          "Function", "@function", "@function.call", "@method", "@constructor",
          "Title",
          "@lsp.typemod.namespace.declaration",
        }, { fg = "#FFFFFF", bold = false })

        set({ "@module", "@namespace", "@lsp.type.namespace" }, { fg = c.package_color })

        set({
          "Type", "@type.builtin", "@lsp.type.builtinType",
          "@lsp.typemod.type.defaultLibrary", "@lsp.typemod.builtin.defaultLibrary",
        }, { fg = c.darker_silver, italic = true })

        set({
          "@type", "@type.definition", "@lsp.type.struct", "@lsp.type.interface",
          "@lsp.type.enum", "@lsp.type.type", "Structure",
        }, { fg = c.white })

        set({
          "Identifier", "@variable", "@variable.parameter",
          "@field", "@property", "@variable.member",
          "@lsp.type.property", "@lsp.type.variable", "@lsp.type.parameter"
        }, { fg = c.white })

        set({ "Operator", "@operator", "Delimiter", "@punctuation.delimiter" }, { fg = c.white })
        set({ "@punctuation.bracket" }, { fg = c.white })
        set({ "String", "Character" }, { fg = c.string_color })
        set({ "Constant", "@constant.builtin", "@variable.builtin" }, { fg = c.darker_silver })


        -- === BAGIAN 2: USER INTERFACE ===
        set({
          "Normal", "NormalNC", "Terminal", "TermNormal",
          "NeoTreeNormal", "NeoTreeNormalNC", "SideBar", "SideBarNC",
          "SnacksNormal", "SnacksNormalNC",
          "SnacksPickerNormal", "SnacksPickerNormalNC",
          "SnacksPickerList", "SnacksPickerPreview", "SnacksLayoutNormal",
          "SnacksDashboardNormal", "SnacksTerminal", "SnacksTerminalNormal"
        }, { bg = c.base })
        set({
          "TelescopeNormal", "TelescopeBorder"
        }, { bg = "NONE" })

        set({
          "Floaterm", "NormalFloat",
          "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb"
        }, { bg = "NONE" })

        set({
          "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator"
        }, { fg = c.black, bg = c.black })

        hl.FloatermBorder = { bg = c.black, fg = colors.border }
        hl.TelescopeBorder = { fg = c.black }
        hl.NeoTreeFloatBorder = { fg = c.black, bg = c.base }
        hl.FloatBorder = { fg = c.black, bg = c.black }
        -- Noice.nvim floating command line styling
        hl.NoiceCmdlinePopupBorder = { fg = c.black, bg = c.black }
        hl.NoiceCmdlinePopupTitle = { fg = c.white, bg = c.black }
        hl.NoiceCmdlineIcon = { fg = c.white, bg = c.black }
        hl.LineNr = { fg = c.grey }
        hl.CursorLineNr = { fg = c.white, bold = true }
        hl.Cursor = { bg = c.cursor, fg = c.black }
        hl.Comment = { fg = "#3a4261" }
        hl.MatchParen = { fg = c.cyan_blue }


        -- === BAGIAN 3: DASHBOARD ===
        set({
            "DashboardHeader", "DashboardCenter", "DashboardFooter",
            "DashboardShortCut", "DashboardIcon", "DashboardKey", "DashboardDesc",
            "SnacksDashboardHeader", "SnacksDashboardIcon", "SnacksDashboardKey",
            "SnacksDashboardDesc", "SnacksDashboardDir", "SnacksDashboardFile",
            "SnacksDashboardFooter", "SnacksDashboardSpecial",
        }, { fg = c.white })


        -- === BAGIAN 4: VISUAL SELECTION ===
        -- Menggunakan warna #333333
        hl.Visual = { bg = "#333333", fg = c.white }

        -- Warna seleksi saat tidak aktif (lebih gelap lagi)
        hl.VisualNOS = { bg = "#333333", fg = c.grey }
      end,
    },
  },

  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
}
