return {
  'nanozuki/tabby.nvim',
  config = function()
    local theme = {
      fill = 'TabLineFill',
      -- Also you can do this:
      -- fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
      head = 'TabLine',
      current_tab = 'TabLineSel',
      tab = 'TabLine',
      win = 'TabLine',
      tail = 'TabLine',
    }
    require('tabby.tabline').set(function(line)
      return {
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab
          return {
            line.sep(' ', hl, theme.fill),
            tab.number(),
            tab.name(),
            hl = hl,
            margin = ' ',
          }
        end),
      }
    end, {
      tab_name = {
        name_fallback = function(tabid)
          local tabnum = vim.api.nvim_tabpage_get_number(tabid)
          local tabcwd = vim.fn.getcwd(-1, tabnum)
          local tabparent
          for parent in vim.fs.parents(tabcwd) do
            tabparent = vim.fs.basename(parent)
            break
          end
          local tabname = vim.fs.basename(tabcwd)
          if tabparent then
            tabname = tabparent .. '/' .. tabname
          end
          return tabname
        end,
      },
    })
  end,
}
