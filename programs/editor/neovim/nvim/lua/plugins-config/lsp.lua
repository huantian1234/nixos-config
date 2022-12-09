require'lspconfig'.tsserver.setup{
    on_attach = on_attach,
		cmd = {"/home/fantasky/.npm-global/bin/typescript-language-server", "--stdio"},
}
