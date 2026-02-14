local dashboard = require("custom.dashboard")

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = dashboard.basmalahArabic,
        },
      },
      picker = {
        backdrop = false,
        win = {
          wo = {
            -- winblend = 0, -- Let the theme handle transparency
          },
        },
        sources = {
          explorer = {
            hidden = true,
            layout = {
              layout = {
                position = "right",
                width = 40,
                box = "vertical",
                { win = "list" },
              },
            },
            win = {
              list = {
                window = { border = "none" },
              },
            },
          },
          files = {
            hidden = true,
          },
        },
      },
      indent = {
        enabled = false,
      },
      dim = {
        enabled = false,
      },
    },
  },

  -- Disable Bufferline (Tab Bar di atas)
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  -- Disable mini.indentscope
  {
    "nvim-mini/mini.indentscope",
    enabled = false,
  },
}
