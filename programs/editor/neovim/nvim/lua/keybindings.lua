--- 保存本地变量
local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }
--- nvimtree
map('n', '<A-m>', ':NvimTreeToggle<CR>', opt)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

local pluginKeys = {}
-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  return {
    -- 上一个
    ['<Up>'] = cmp.mapping.select_prev_item(),
    -- 下一个
    ['<Down>'] = cmp.mapping.select_next_item(),
    -- 出现补全
    ['<A-.>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- 取消
    ['<A-,>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- 确认
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({
      select = true ,
      behavior = cmp.ConfirmBehavior.Replace
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      local entry = cmp.get_selected_entry()
      if cmp.visible() and not entry then
        cmp.select_next_item()
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
      elseif cmp.visible() and entry then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end 
    end,{'i','s'}
    ),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  }
end
return pluginKeys
