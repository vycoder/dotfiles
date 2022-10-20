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
    "volar",
    "tsserver",
  },
  filter = function(client)
    if vim.bo.filetype == "javascript" then return client.name == "null-ls" end
    if vim.bo.filetype == "typescript" then return client.name == "null-ls" end
    return true
  end,
  timeout_ms = 1000, -- default format timeout
}
