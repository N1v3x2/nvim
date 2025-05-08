--- @type LazySpec
return {
  'vimpostor/vim-tpipeline',
  config = function()
    vim.g.tpipeline_fillcentre = 1
    vim.g.tpipeline_clearstl = 1
  end,
}
