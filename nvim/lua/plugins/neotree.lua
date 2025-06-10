return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    config = function()
      require("neo-tree").setup({
        filesystem = {
          hijack_netrw_behavior = "disabled",
          hijack_netrw = true,
        },
        sources = { "filesystem", "git_status" },
        source_selector = {
          winbar = true,
	  statusline = false,
	},
        window = {
          position = "right",
          width = 30,
	  mappings = {
	    ["l"] = "open",
	    ["h"] = "close_node",
	    ["<cr>"] = "open",
	  },
        },
	git_status = {
	    symbols = {
	      added     = "✚",
	      modified  = "",
	      deleted   = "✖",
	      renamed   = "󰁕",
	      untracked = "",
	      ignored   = "",
	      unstaged  = "󰄱",
	      staged    = "",
	      conflict  = "",
	    },
	},
      })
	vim.keymap.set("n", "<leader>e", function()
	  require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
	end, { desc = "Toggle NeoTree" })

	-- Focus Neo-tree (open if needed, then jump into it)
	vim.keymap.set("n", "<leader>fe", function()
	  require("neo-tree.command").execute({ toggle = false, reveal = true, dir = vim.loop.cwd(), focus = true })
	end, { desc = "Focus NeoTree" })

	-- Unfocus Neo-tree (jump to previous window)
	vim.keymap.set("n", "<leader>uf", "<C-w>p", { desc = "Unfocus NeoTree (go to previous window)" })
	
	vim.keymap.set("n", "<leader>gs", function()
	  require("neo-tree.command").execute({ source = "git_status", toggle = true })
	end, { desc = "Toggle NeoTree Git Status" })
    end,
  },
}
