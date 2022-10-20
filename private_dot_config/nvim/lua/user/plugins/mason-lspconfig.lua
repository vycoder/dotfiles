-- use mason-lspconfig to configure LSP installations
return { -- overrides `require("mason-lspconfig").setup(...)`
  -- ensure_installed = { "sumneko_lua" },
  ensure_installed = {
    "jdtls",
    "cssls",
    "html",
    "bashls",
    "emmet_ls",
    "sumneko_lua",
    "volar",
    "tsserver",
    "yamlls",
    "rust_analyzer",
  },
}
