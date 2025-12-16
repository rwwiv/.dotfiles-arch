return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        -- 1. Use the shared daemon to persist analysis between Neovim restarts
        cmd = { "gopls", "-remote=auto" },

        settings = {
          gopls = {
            -- 2. Aggressively filter non-Go directories (adjust for your repo)
            directoryFilters = {
              "-node_modules",
              -- grafana/grafana specific
              "-public",
              "-packages",
              "-cue.mod",
              "-.github",
              "-devenv",
              "-scripts",
              "-e2e",
            }, -- Don't scan the whole module if you only opened a subdir
            expandWorkspaceToModule = false,
          },
        },
      },
    },
  },
}
