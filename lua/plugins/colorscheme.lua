local get_colorscheme = require("user.funs").get_colorscheme
local set_colorscheme = require("user.funs").set_colorscheme
local opts = require("user.opts")

-- @param name: string
-- @param variants: table
-- @return boolean
local check_variant = function(name,variants)
  for _,v in pairs(variants) do
    if name == v then
      return true
    end
  end
  return false
end

return {
  -- Tokyonight theme
  {
    "folke/tokyonight.nvim", -- https://github.com/folke/tokyonight.nvim/releases/latest

    config = function()
      local variants = {
        "tokyonight",
        "tokyonight-day",
        "tokyonight-night",
        "tokyonight-moon",
        "tokyonight-storm",
      }
      -- check if the colorscheme is in the list of variants
      require("tokyonight").setup({
        transparent = opts.bg_is_transparent,
        sidebars = { "qf", "help", "harpoon", "TelescopePrompt" }, -- filetype windows with darker background
        day_brightness = 0.3, -- only used if `day` is set
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
      })

      local colorscheme = get_colorscheme()
      if not check_variant(colorscheme, variants) then
        return
      else
        set_colorscheme(colorscheme)
      end

    end,
  },
  -- GitHub theme
  {
    "projekt0n/github-nvim-theme",
    config = function()
      local variants = {
        "github_dark",
        "github_dark_colorblind",
        "github_dark_default",
        "github_dark_dimmed",
        "github_dark_high_contrast",
        "github_dark_tritanopia",
        "github_light",
        "github_light_colorblind",
        "github_light_default",
        "github_light_high_contrast",
        "github_light_tritanopia",
      }

      require("github-theme").setup({
        options = { transparent = opts.bg_is_transparent },
      })

      local colorscheme = get_colorscheme()
      if not check_variant(colorscheme, variants) then
        return
      else
        set_colorscheme(colorscheme)
      end

    end,
  },
}
