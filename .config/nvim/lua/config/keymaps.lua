-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Helix-style selections
map("n", "%", "ggVG", { desc = "Select entire file" }) -- Helix's %

-- Helix goto mode (g prefix)
map("n", "gh", "0", { desc = "Goto line start" }) -- Helix gh
map("n", "gl", "$", { desc = "Goto line end" }) -- Helix gl
map("n", "gs", "^", { desc = "Goto first non-blank" }) -- Helix gs
map("n", "ge", "G", { desc = "Goto last line" }) -- Helix ge
map("n", "gt", "gg", { desc = "Goto first line" }) -- Helix gt

-- Helix match mode (m prefix)
map("n", "mm", "%", { desc = "Goto matching bracket" }) -- Helix mm

-- Helix's nice extras
map("n", "U", "<C-r>", { desc = "Redo" }) -- Helix U for redo (Vim's is Ctrl-r)
map("n", "&", ":s//g<Left><Left>", { desc = "Replace in line" }) -- Helix &

-- Helix space mode shortcuts (already mostly covered by LazyVim's <leader>)
map("n", "<leader>w", ":w<CR>", { desc = "Write/Save" }) -- Space-w in Helix

-- Extend selection commands
map("v", "%", "ggVG", { desc = "Select entire file" })

-- Helix x/X for line selection
map("n", "x", "V", { desc = "Select line" })
map("v", "x", "j", { desc = "Extend line down" })
map("v", "X", "k", { desc = "Extend line up" })

-- Helix window splitting
map("n", "<C-w>v", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<C-w>s", ":split<CR>", { desc = "Horizontal split" })

-- Jump to matching bracket (Helix mm)
map("n", "mm", "%", { desc = "Jump to matching bracket" })

-- Select inside brackets/quotes (Helix mi)
map("n", "mi(", "vi(", { desc = "Select inside ()" })
map("n", "mi)", "vi)", { desc = "Select inside ()" })
map("n", "mi{", "vi{", { desc = "Select inside {}" })
map("n", "mi}", "vi}", { desc = "Select inside {}" })
map("n", "mi[", "vi[", { desc = "Select inside []" })
map("n", "mi]", "vi]", { desc = "Select inside []" })
map("n", 'mi"', 'vi"', { desc = 'Select inside ""' })
map("n", "mi'", "vi'", { desc = "Select inside ''" })
map("n", "mi`", "vi`", { desc = "Select inside ``" })
map("n", "mi<", "vi<", { desc = "Select inside <>" })
map("n", "mi>", "vi>", { desc = "Select inside <>" })

-- Select around brackets/quotes (Helix ma)
map("n", "ma(", "va(", { desc = "Select around ()" })
map("n", "ma)", "va)", { desc = "Select around ()" })
map("n", "ma{", "va{", { desc = "Select around {}" })
map("n", "ma}", "va}", { desc = "Select around {}" })
map("n", "ma[", "va[", { desc = "Select around []" })
map("n", "ma]", "va]", { desc = "Select around []" })
map("n", 'ma"', 'va"', { desc = 'Select around ""' })
map("n", "ma'", "va'", { desc = "Select around ''" })
map("n", "ma`", "va`", { desc = "Select around ``" })
map("n", "ma<", "va<", { desc = "Select around <>" })
map("n", "ma>", "va>", { desc = "Select around <>" })

-- Bonus: word/WORD selections
map("n", "miw", "viw", { desc = "Select inside word" })
map("n", "miW", "viW", { desc = "Select inside WORD" })
map("n", "maw", "vaw", { desc = "Select around word" })
map("n", "maW", "vaW", { desc = "Select around WORD" })

map("v", "p", '"_dP', { desc = "Paste without yanking" })

map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>Q", ":qa<CR>", { desc = "Quit all" })

map("n", "<C-c>", "gcc", { desc = "Toggle comment line", remap = true })
map("v", "<C-c>", "gc", { desc = "Toggle comment", remap = true })

map("n", ">", ">>", { desc = "Indent line" })
map("n", "<", "<<", { desc = "Dedent line" })

map({ "v" }, "<", "<gv", { desc = "Indent left" })
map({ "v" }, ">", ">gv", { desc = "Indent right" })

map({ "n", "v" }, "W", "b", { desc = "Backward WORD" })
map({ "n", "v" }, "E", "ge", { desc = "Backward to end of word" })
