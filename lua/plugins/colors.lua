local useropts = require("user.opts")

return {
  -- Colorizer - colorize colorcodes (<leader>-c to toggle)
  {
    "norcalli/nvim-colorizer.lua",
    opts = {},
    VeryLazy = true,
    cmd = { "ColorizerAttachToBuffer", "ColorizerToggle" },
  },
  -- Tokyonight theme
  {
    "folke/tokyonight.nvim", -- https://github.com/folke/tokyonight.nvim/releases/latest
    opts = {
      transparent = useropts.bg_is_transparent,
      sidebars = { "qf", "help", "harpoon", "TelescopePrompt" }, -- filetype windows with darker background
      day_brightness = 0.3, -- only used if `day` is set
      lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
    },
  },
  -- Rosepine theme
  {
    "rose-pine/neovim", -- https://github.com/rose-pine/neovim/releases/latest
    name = "rose-pine",
    opts = {
      dim_inactive_windows = true,
      styles = { transparency = useropts.bg_is_transparent },
    },
  },
}
