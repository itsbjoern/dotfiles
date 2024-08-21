local wezterm = require 'wezterm'

local function isempty(s)
  return s == nil or s == ''
end

local config = wezterm.config_builder()
local username = os.getenv('USER') or os.getenv('LOGNAME') or os.getenv('USERNAME')

config.set_environment_variables = {
  PATH = '/opt/homebrew/bin:' .. os.getenv('PATH'),
}

config.bypass_mouse_reporting_modifiers = 'ALT'
config.enable_scroll_bar = true

config.font_dirs = {
  ("/Users/" .. username .. "/dotfiles/fonts"),
  ("/Users/" .. username .. "code/dotfiles/src/dotfiles/fonts"),
}

config.colors = {
  foreground = "#c8cdd5",
  background = "#282c34",

  cursor_fg = "#c8cde5",
  cursor_bg = "#484c60",
  cursor_border = "#484c60",

  selection_fg = "#c8cde5",
  selection_bg = "#585c80",

  -- ansi = {
  --   'black',
  --   'maroon',
  --   'green',
  --   'olive',
  --   'navy',
  --   'purple',
  --   'teal',
  --   'silver',
  -- },
  -- brights = {
  --   'grey',
  --   'red',
  --   'lime',
  --   'yellow',
  --   'blue',
  --   'fuchsia',
  --   'aqua',
  --   'white',
  -- },

  ansi = {
    '#4a4a4a',
    'hsl(354.47deg 100% 85.1%)',
    'hsl(133.04deg 100% 86.47%)',
    'hsl(262.11deg 100% 85.1%)',
    'hsl(206.09deg 100% 86.47%)',
    'hsl(262.11deg 100% 85.1%)',
    'hsl(176.13deg 100% 86.47%)',
    'silver',
  },
}

config.window_frame = {
  active_titlebar_bg = "#1d2127",
  inactive_titlebar_bg = "#1d2127",

  font_size = 10.0,

  font = wezterm.font_with_fallback({
    {family="SF Mono", weight="DemiBold"},
    {family="Menlo", weight="Regular"},
    {family="JetBrains Mono"},
    {family="Symbols Nerd Font Mono"},
  })
}

config.window_decorations = "RESIZE"
config.default_prog = { 'fish', '-l' }

config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
-- config.show_close_tab_button_in_tabs = false
config.pane_focus_follows_mouse = true

config.adjust_window_size_when_changing_font_size = false
config.inactive_pane_hsb = { brightness = 0.9 }
config.window_padding = {
  left = 15,
  right = 15,
  top = 15,
  bottom = 0
}

local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider


config.font = wezterm.font_with_fallback({
  {family="SF Mono", weight="DemiBold"},
  {family="Menlo", weight="Regular"},
  {family="JetBrains Mono"},
  {family="Symbols Nerd Font Mono"},
})

config.font_size = 11.7
config.line_height = 1.02

function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

env_cache = {}

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    local user_vars = tab.active_pane.user_vars

    for k, v in pairs(user_vars) do
      env_cache[k] = v
    end

    local venv_name = user_vars.VIRTUAL_ENV_NAME or env_cache.VIRTUAL_ENV_NAME
    local venv_path = user_vars.VIRTUAL_ENV_REL_PATH or env_cache.VIRTUAL_ENV_REL_PATH
    local is_project = user_vars.VIRTUAL_ENV_IS_PROJECT or env_cache.VIRTUAL_ENV_IS_PROJECT
    if not isempty(venv_name) then
      title = venv_name .. " " .. venv_path
    end

    local title = tostring(tab.tab_index + 1) .. ' ' .. string.format("%-" .. math.max(4 - string.len(title), 1) .. "s", title)

    if tab.is_active then
      return {
        { Background = { Color = '#282c34' } },
        { Text = ' ' .. title .. ' ' },
      }
    end
    return ' ' .. title .. ' '
  end
)

wezterm.on('update-right-status', function(window, pane)
  local user_vars = pane:get_user_vars()
  local path = user_vars.VIRTUAL_ENV_REL_PATH or ""

  local status_list = {
    { Background = { Color = "#1d2127" } },
    { Text = path },
  }

  local venv_name = user_vars.VIRTUAL_ENV_NAME
  if not isempty(venv_name) then
    table.insert(status_list, { Text = " // " })
    table.insert(status_list, { Text = venv_name })
  end

  local git_branch = user_vars.GIT_BRANCH_STATUS
  if not isempty(git_branch) then
    table.insert(status_list, { Text = " [" })
    table.insert(status_list, { Text = git_branch })
    table.insert(status_list, { Text = "]" })
  end

  table.insert(status_list, { Text = " " })

  window:set_right_status(wezterm.format(status_list))
end)


config.mouse_bindings = {
  -- Open URLs with CMD+Click
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}


config.keys = {
  -- CTRL-SHIFT-l activates the debug overlay
  { key = 'p', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay },

   -- Vertical pipe (|) -> horizontal split
   {
    key = '\\',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitHorizontal {
      domain = 'CurrentPaneDomain'
    },
  },
  -- Underscore (_) -> vertical split
  {
    key = '\\',
    mods = 'CMD',
    action = wezterm.action.SplitVertical {
      domain = 'CurrentPaneDomain'
    },
  },

    -- Move to a pane (prompt to which one)
    {
      mods = "CMD", key = "m",
      action = wezterm.action.PaneSelect
    },

    {
      key = "LeftArrow",
      mods = "CMD",
      action = wezterm.action.ActivatePaneDirection('Left')
    },
    {
      key = "RightArrow",
      mods = "CMD",
      action = wezterm.action.ActivatePaneDirection('Right')
    },
    {
      key = "DownArrow",
      mods = "CMD",
      action = wezterm.action.ActivatePaneDirection('Down')
    },
    {
      key = "UpArrow",
      mods = "CMD",
      action = wezterm.action.ActivatePaneDirection('Up')
    },

    {
      key = "LeftArrow",
      mods = "SHIFT|CMD",
      action = wezterm.action.MoveTabRelative(-1)
    },
    {
      key = "RightArrow",
      mods = "SHIFT|CMD",
      action = wezterm.action.MoveTabRelative(1)
    },

    -- w to close pane, CMD+w to close tab
    {
      key = "w",
      mods = "CMD",
      action = wezterm.action.CloseCurrentPane { confirm = true }
    },

    {
      key = "w",
      mods = "CMD|SHIFT",
      action = wezterm.action.CloseCurrentTab { confirm = true }
    },

      -- Use CMD+z to enter zoom state
    {
      key = 'z',
      mods = 'CMD',
      action = wezterm.action.TogglePaneZoomState,
    },
}


return config
