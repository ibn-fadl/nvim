return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            layout = {
              layout = {
                position = "right",
                width = 30,
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
        },
      },
    },
  },
  
  -- Disable Bufferline (Tab Bar di atas)
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
}