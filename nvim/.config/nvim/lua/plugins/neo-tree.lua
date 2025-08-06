return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,

  config = function()
    vim.keymap.set('n', '<leader>r', ':Neotree filesystem reveal left<CR>')

    vim.keymap.set("n", "<leader>e", "<cmd>Neotree close filesystem<CR>", {
      desc = "Close Neo-tree",
    })
  end
}
