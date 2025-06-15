return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",  desc = "Delete Buffers to the Left" },
      { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",  desc = "Prev Buffer" },
      { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",  desc = "Next Buffer" },
      { "<S-W>",      "<cmd>bd!<cr>",                  desc = "Close Current Buffer (force)" },
    },
    opts = {},
  }
}
