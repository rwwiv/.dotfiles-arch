-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto-open Neotest Output Panel on failure
vim.api.nvim_create_autocmd("User", {
  pattern = "NeotestRunComplete",
  callback = function()
    local neotest = require("neotest")
    local adapters = neotest.state.adapter_ids()
    local has_failed = false

    for _, adapter_id in ipairs(adapters) do
      local results = neotest.state.results(adapter_id)
      for _, result in pairs(results) do
        if result.status == "failed" then
          has_failed = true
          break
        end
      end
    end

    if has_failed then
      neotest.output_panel.open()
    else
      neotest.output_panel.close()
    end
  end,
})
