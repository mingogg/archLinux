return {
  --  {
  --    "catppuccin/nvim",
  --  name = "catppuccin",
  --  priority = 1000,
  --  config = function()
  --    vim.cmd.colorscheme "catppuccin-frappe"
  --  end
  --  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("tokyonight").setup({
        styles = {
          comments = { italic = false },
        },
      })
      vim.cmd.colorscheme("tokyonight-storm")
    end,
  }
}
