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
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      day_brightness = 0.3, -- only used if `day` is set
      lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
    },
  },
  -- Rosepine theme
  {
    "rose-pine/neovim", -- https://github.com/rose-pine/neovim/releases/latest
    name = "rose-pine",
    opts = {
      styles = {
        bold = true,
        italic = false,
        transparency = useropts.bg_is_transparent,
      },
      dim_inactive_windows = true,
    },
  },
}
