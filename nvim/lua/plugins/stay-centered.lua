return {
  {
    "arnamak/stay-centered.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader><Tab>",
        function()
          require("stay-centered").toggle()
          vim.notify("Toggled stay-centered", vim.log.levels.INFO)
        end,
        desc = "Toggle stay-centered.nvim",
      },
    },
  },
}
