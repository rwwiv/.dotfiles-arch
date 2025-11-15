return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- Remove golangci-lint from Go linters
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.go = vim.tbl_filter(function(linter)
        return linter ~= "golangci-lint"
      end, opts.linters_by_ft.go or {})
    end,
  },
}
