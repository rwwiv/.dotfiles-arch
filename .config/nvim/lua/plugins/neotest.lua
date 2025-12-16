return {
  "nvim-neotest/neotest",
  -- Do not add dependencies here if you are using LazyExtras!

  -- 1. Your Keymaps
  keys = {
    {
      "<leader>tr",
      function()
        require("neotest").output_panel.clear()
        require("neotest").run.run()
      end,
      desc = "Clear & Run Nearest",
    },
    {
      "<leader>tt",
      function()
        require("neotest").output_panel.clear()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Clear & Run File",
    },
    {
      "<leader>tT",
      function()
        local neotest = require("neotest")
        local adapters = neotest.state.adapter_ids()
        if #adapters > 0 then
          vim.ui.select(adapters, { prompt = "Select Adapter" }, function(adapter)
            if adapter then
              neotest.output_panel.clear()
              neotest.run.run({ vim.fn.getcwd(), adapter = adapter })
            end
          end)
        end
      end,
      desc = "Clear & Run All",
    },
  },

  -- 2. Settings Overrides
  opts = function(_, opts)
    -- 1. Set your static configuration preferences here
    opts.output = { open_on_run = false }
    opts.output_panel = { enabled = true, open = "botright split | resize 15" }

    -- 2. Handle the adapter logic (Safe Find & Replace)
    -- Check if adapters table exists, then look for neotest-go
    if opts.adapters then
      for i, adapter in ipairs(opts.adapters) do
        if adapter.name == "neotest-go" then
          opts.adapters[i] = require("neotest-go")({
            warn_test_name_dupes = false,
          })
          return
        end
      end
    end
  end,
}
