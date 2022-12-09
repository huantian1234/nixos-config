--utf-8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "UTF-8"
--相对行号
vim.wo.number = true
vim.wo.relativenumber = true
--高亮所在行
vim.wo.cursorline = true
--搜索不高亮
vim.o.hlsearch = false
--不可见字符显示
vim.o.list = true
vim.o.listchars = "space:.,tab:->"
-- 缩进2个空格等于一个Tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
-- >> << 时移动长度
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- 新行对齐当前行，空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
