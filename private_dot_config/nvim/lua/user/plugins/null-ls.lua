return function(config) -- overrides `require("null-ls").setup(config)`
  -- config variable is the default configuration table for the setup function call
  local null_ls = require "null-ls"

  -- Check supported formatters and linters
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  config.sources = {
    -- Set a formatter
    -- Set a formatter
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.rustfmt,
    -- Code actions
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.refactoring,
  }
  return config -- return final config table
end
