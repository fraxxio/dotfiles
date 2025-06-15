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
        sources = { "filesystem" },
        window = {
          position = "right",
          width    = 30,
          mappings = {
            l     = "open",
            h     = "close_node",
            ["<cr>"] = "open",
          },
        },
      })

      -- all keymaps must be here, inside config:
      vim.keymap.set("n", "<leader>e", function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end, { desc = "Toggle NeoTree" })

      vim.keymap.set("n", "<leader>fe", function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname:match("neo%-tree") then
          vim.cmd("wincmd p")
        else
          require("neo-tree.command").execute({
            toggle = false,
            reveal = true,
            dir    = vim.loop.cwd(),
            focus  = true,
          })
        end
      end, { desc = "Toggle Focus on NeoTree" })
    end,
  },
}
