return {
  --  {
  --    "catppuccin/nvim",
  --  name = "catppuccin",
  --  priority = 1000,
  --  config = function()
  --    vim.cmd.colorscheme "catppuccin-frappe"
  --  end
  --  },
  -- {
  --   "folke/tokyonight.nvim",
  --   priority = 1000,
  --   config = function()
  --     ---@diagnostic disable-next-line: missing-fields
  --     require("tokyonight").setup({
  --       styles = {
  --         comments = { italic = false },
  --       },
  --     })
  --     vim.cmd.colorscheme("tokyonight-storm")
  --   end,
  -- }
  {
    "rose-pine/nvim",
    name = "rose-pine-moon",
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        dark_variant = "moon",
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true,
          migrations = true,
        },

        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },

        groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
      })

      -- vim.cmd("colorscheme rose-pine-main")
      vim.cmd("colorscheme rose-pine-moon")
      -- vim.cmd("colorscheme rose-pine-dawn")
    end
  }
}
