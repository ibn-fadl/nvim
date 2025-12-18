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
      dim = 0.4,
      cleaning_interval = 1250,
    },
    trigger_events = { "InsertLeave", "TextChanged" },
    condition = function(buf)
      -- First, check if the buffer is still valid to prevent errors.
      if not vim.api.nvim_buf_is_valid(buf) then
        return false
      end

      -- Exclude special buffers and filetypes
      local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
      local fts = { "TelescopePrompt", "NvimTree", "gitcommit", "gitrebase", "svn", "hgcommit" }
      if
        buftype ~= "" -- Exclude non-normal buffers
        or vim.tbl_contains(fts, vim.bo[buf].filetype) -- Exclude specific filetypes
      then
        return false
      end
      return true -- If all checks pass, allow auto-saving
    end,
    write_all_buffers = false,
    debounce_delay = 135,
  },
}
