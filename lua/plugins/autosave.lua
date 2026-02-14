-- pocco81/auto-save.nvim: A plugin for auto-saving buffers
return {
  "pocco81/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    enabled = true,
    execution_message = {
      message = function()
        return "✓ auto-saved"
      end,
      dim = 0,
      cleaning_interval = 1250,
    },
    trigger_events = { "InsertLeave", "TextChanged" },
    condition = function(buf)
      -- Use early returns to make the conditions clearer
      if not vim.api.nvim_buf_is_valid(buf) then
        return false
      end

      -- Exclude special buffers
      local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
      if buftype ~= "" then
        return false
      end

      -- Exclude specific filetypes
      local fts = { "TelescopePrompt", "NvimTree", "gitcommit", "gitrebase", "svn", "hgcommit" }
      if vim.tbl_contains(fts, vim.bo[buf].filetype) then
        return false
      end

      -- If all checks pass, allow auto-saving
      return true
    end,
    write_all_buffers = false,
    debounce_delay = 135,
  },
}
