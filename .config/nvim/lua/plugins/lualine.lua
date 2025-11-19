return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Move everything from y to z
    opts.sections.lualine_z = opts.sections.lualine_y
    opts.sections.lualine_y = {}

    return opts
  end,
}
