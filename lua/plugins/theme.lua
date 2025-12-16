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

      -- 1. CONFIG: Warna Dasar Global
      on_colors = function(colors)
        local main_bg = "#0a0a0a"
        local pop_bg  = "#000000"

        colors.bg = main_bg
        colors.bg_sidebar = main_bg
        colors.bg_dark = pop_bg
        colors.bg_float = pop_bg
        colors.bg_popup = pop_bg
        colors.border = "#ffffff"
        colors.fg = "#d4d6c6"
      end,

      -- 2. CONFIG: Highlight Overrides
      on_highlights = function(hl, colors)
        -- A. PALET WARNA
        local c = {
          base      = "#0a0a0a",
          black     = "#000000",
          text      = "#d4d6c6",
          white     = "#ffffff",

          -- COLOR CONFIG:
          pink_bright = "#f30974", -- Structs
          pink_dark   = "#ab0652", -- Primitives

          -- NEW COLOR:
          green_lime  = "#bae67e", -- Package Imports/Namespaces (os, fmt, dll)

          blue      = "#1ea8fc",   -- Keywords
          purple    = "#d699ff",   -- Brackets/Operators
          cyan      = "#80e5ff",   -- Strings
          pale      = "#cebbfa",   -- Constants
          grey      = "#505050",
          cursor    = "#FF0000",
        }

        -- Helper
        local function set(groups, opts)
          for _, group in ipairs(groups) do hl[group] = opts end
        end

        -- === BAGIAN 1: SYNTAX HIGHLIGHTING ===

        -- 1. Keywords (Blue)
        set({
          "Keyword", "Statement", "Conditional", "Repeat", "Include",
          "Structure", "Define", "PreProc", "Exception",
          "@keyword", "@keyword.function", "@keyword.import", "@include"
        }, { fg = c.blue, italic = false })

        -- 2. Identifiers: Functions, Methods (White)
        -- NOTE: @module dan @namespace dipindahkan dari sini agar bisa jadi hijau
        set({
          "Function", "@function", "@function.call", "@method", "@constructor",
          "Title",
          -- FIX: Memaksa DEFINISI package (package main) tetap Putih
          "@lsp.typemod.namespace.declaration",
        }, { fg = c.white, bold = false })

        -- 3. IMPORTED PACKAGES / NAMESPACES (Lime Green #bae67e) -> NEW
        -- Ini akan mewarnai 'os' di os.Exit, 'fmt' di fmt.Println
        set({
          "@module",
          "@namespace",
          "@lsp.type.namespace",
        }, { fg = c.green_lime })

        -- 4a. BUILT-IN TYPES (PRIMITIVE -> DARK PINK & ITALIC)
        set({
          "Type",
          "@type.builtin",
          "@lsp.type.builtinType",
          "@lsp.typemod.type.defaultLibrary",
          "@lsp.typemod.builtin.defaultLibrary",
        }, { fg = c.pink_dark, italic = true })

        -- 4b. USER DEFINED TYPES (STRUCTS -> BRIGHT PINK)
        set({
          "@type",
          "@type.definition",
          "@lsp.type.struct",
          "@lsp.type.interface",
          "@lsp.type.enum",
          "@lsp.type.type",
          "Structure",
        }, { fg = c.pink_bright })

        -- 5. Variables & Fields (Bright Sage)
        set({
          "Identifier", "@variable", "@variable.parameter",
          "@field", "@property", "@variable.member",
          "@lsp.type.property", "@lsp.type.variable", "@lsp.type.parameter"
        }, { fg = c.text })

        -- 6. Operators & Punctuation (Lavender)
        set({
          "Operator", "@operator",
          "Delimiter", "@punctuation.delimiter", "@punctuation.bracket"
        }, { fg = c.purple })

        -- 7. Strings (Cyan)
        set({ "String", "Character" }, { fg = c.cyan })

        -- 8. Constants (Pale Purple)
        set({ "Constant", "@constant.builtin" }, { fg = c.pale })


        -- === BAGIAN 2: USER INTERFACE ===

        -- 1. Main Background (Seamless #0a0a0a)
        set({
          "Normal", "NormalNC",
          "Terminal", "TermNormal",
          "NeoTreeNormal", "NeoTreeNormalNC", "SideBar", "SideBarNC",
          "SnacksNormal", "SnacksNormalNC",
          "SnacksPickerNormal", "SnacksPickerNormalNC",
          "SnacksPickerList", "SnacksPickerPreview", "SnacksLayoutNormal",
          "SnacksDashboardNormal", "SnacksTerminal", "SnacksTerminalNormal",
          "TelescopeNormal", "TelescopeBorder"
        }, { bg = c.base })

        -- 2. Floating Background (Black #000000)
        set({
          "Floaterm", "NormalFloat",
          "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb"
        }, { bg = c.black })

        -- 3. Separators
        set({
          "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator"
        }, { fg = c.base, bg = c.base })

        hl.FloatermBorder = { bg = c.black, fg = colors.border }

        -- 4. Utils
        hl.LineNr = { fg = c.grey }
        hl.CursorLineNr = { fg = c.white, bold = true }
        hl.Cursor = { bg = c.cursor, fg = c.black }
      end,
    },
  },

  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
}
