return function(client)
  if vim.tbl_contains({
    "volar",
  }, client.name) then astronvim.lsp.disable_formatting(client) end
end
