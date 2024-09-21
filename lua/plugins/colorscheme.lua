local opts = require("user.opts")
return {
  -- Tokyonight theme
  {
    "folke/tokyonight.nvim", -- https://github.com/folke/tokyonight.nvim/releases/latest

    config = function()
      local colorscheme = require("user.opts").colorscheme
      local variants = {
        "tokyonight",
        "tokyonight-day",
        "tokyonight-night",
        "tokyonight-moon",
        "tokyonight-storm",
      }
      -- check if the colorscheme is in the list of variants
      local variant
      for _, v in pairs(variants) do
        if not colorscheme == v then
          return
        else
          variant = v
        end
      end

      require("tokyonight").setup({
        transparent = opts.bg_is_transparent,
        sidebars = { "qf", "help", "harpoon", "TelescopePrompt" }, -- filetype windows with darker background
        day_brightness = 0.3, -- only used if `day` is set
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
      })

      -- set the scheme
      vim.cmd("colorscheme " .. variant)
    end,
  },
  -- GitHub theme
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = { transparent = opts.bg_is_transparent },
      })
    end,
  },
}
