local cmp = require'cmp'
cmp.setup {
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }),
	 -- 快捷键
  mapping = require("keybindings").cmp(cmp),
}
