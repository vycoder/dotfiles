return {
  -- control auto formatting on save
  format_on_save = {
    enabled = true, -- enable or disable format on save globally
    disable_filetypes = { -- disable format on save for specified filetypes
      -- "python",
    },
  },
  disabled = { -- disable formatting capabilities for the listed language servers
    -- "sumneko_lua",
    -- "tsserver",
  },
  filter = function(client)
    if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" or vim.bo.filetype == "vue" then
      return client.name == "null-ls"
    end
    return true
  end,
  timeout_ms = 2000, -- default format timeout
}
