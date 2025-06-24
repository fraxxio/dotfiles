return {
  "numToStr/Comment.nvim",
  opts = {
    post_hook = function(ctx)
      local U = require("Comment.utils")
      if ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        vim.cmd("norm! gv")
      end
    end,
  },
  keys = {
    { "<C-_>", "gcc", mode = "n", remap = true, desc = "Toggle comment line" },
    { "<C-_>", "gc",  mode = "x", remap = true, desc = "Toggle comment selection" },
  },
}
