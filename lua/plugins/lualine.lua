local function print_player_status()
  local width = vim.o.columns
  if width <= 100 then
    return ""
  else
    local ssh_client = os.getenv("SSH_CLIENT")
    if ssh_client then
      -- return "󰰡󰰡󰰀"
      return ""
    else
      local command = "playerctl status -a 2>/dev/null"
      local handle = io.popen(command)
      local read = handle:read("*a")
      handle:close()
      if string.find(read, "Playing") then
        --   ⠁ ⠂ ⠃ ⠄ ⠅ ⠆ ⠇ ⠈ ⠉ ⠊ ⠋ ⠌ ⠍ ⠎ ⠏ ⠐ ⠑ ⠒ ⠓ ⠔ ⠕ ⠖ ⠗ ⠘ ⠙ ⠚ ⠛ ⠜ ⠝ ⠞ ⠟ ⠠ ⠡ ⠢ ⠣ ⠤ ⠥ ⠦ ⠧ ⠨ ⠩ ⠪ ⠫ ⠬ ⠭ ⠮ ⠯ ⠰ ⠱ ⠲ ⠳ ⠴ ⠵ ⠶ ⠷ ⠸ ⠹ ⠺ ⠻ ⠼ ⠽ ⠾ ⠿

        -- ⡀ ⡁ ⡂ ⡃ ⡄ ⡅ ⡆ ⡇ ⡈ ⡉ ⡊ ⡋ ⡌ ⡍ ⡎ ⡏ ⡐ ⡑ ⡒ ⡓ ⡔ ⡕ ⡖ ⡗ ⡘ ⡙ ⡚ ⡛ ⡜ ⡝ ⡞ ⡟ ⡠ ⡡ ⡢ ⡣ ⡤ ⡥ ⡦ ⡧ ⡨ ⡩ ⡪ ⡫ ⡬ ⡭ ⡮ ⡯ ⡰ ⡱ ⡲ ⡳ ⡴ ⡵ ⡶ ⡷ ⡸ ⡹ ⡺ ⡻ ⡼ ⡽ ⡾ ⡿

        -- ⢀ ⢁ ⢂ ⢃ ⢄ ⢅ ⢆ ⢇ ⢈ ⢉ ⢊ ⢋ ⢌ ⢍ ⢎ ⢏ ⢐ ⢑ ⢒ ⢓ ⢔ ⢕ ⢖ ⢗ ⢘ ⢙ ⢚ ⢛ ⢜ ⢝ ⢞ ⢟ ⢠ ⢡ ⢢ ⢣ ⢤ ⢥ ⢦ ⢧ ⢨ ⢩ ⢪ ⢫ ⢬ ⢭ ⢮ ⢯ ⢰ ⢱ ⢲ ⢳ ⢴ ⢵ ⢶ ⢷ ⢸ ⢹ ⢺ ⢻ ⢼ ⢽ ⢾ ⢿

        -- ⣀ ⣁ ⣂ ⣃ ⣄ ⣅ ⣆ ⣇ ⣈ ⣉ ⣊ ⣋ ⣌ ⣍ ⣎ ⣏ ⣐ ⣑ ⣒ ⣓ ⣔ ⣕ ⣖ ⣗ ⣘ ⣙ ⣚ ⣛ ⣜ ⣝ ⣞ ⣟ ⣠ ⣡ ⣢ ⣣ ⣤ ⣥ ⣦ ⣧ ⣨ ⣩ ⣪ ⣫ ⣬ ⣭ ⣮ ⣯ ⣰ ⣱ ⣲ ⣳ ⣴ ⣵ ⣶ ⣷ ⣸ ⣹ ⣺ ⣻ ⣼ ⣽ ⣾ ⣿
        -- local characters = {'⣀', '⣁', '⣂', '⣄', '⣅', '⣆', '⣇', '⣏', '⣗', '⣧','⣯', '⣷', '⣿'}
        -- local characters = {"⢁", "⠢", "⠔", "⡈"}
        local characters = {"⠸⡆", "⠱⢆", "⠲⠦", "⠴⠖", "⡰⠎", "⢰⠇"}
        local animation = os.time() % table.getn(characters)
        return "" .. characters[animation+1]
      end
      return "  "
    end
  end
end

local theme = require'lualine.themes.vscode'
local ll = require('lualine')

local function print_mode()
  local mode = vim.api.nvim_get_mode()["mode"]
  if mode == "n" then
    return "N"
    -- return ""
  elseif mode == "i" then
    return "I"
    -- return ""
  elseif mode == "R" then
    return "R"
    -- return "󰑖"
  elseif mode == "t" then
    return "T"
    -- return ""
  elseif mode == "v" then
    return "V"
  elseif mode == "c" then
    return "C"
    -- return ""
  end
  return mode
end

local function get_mode_color(section)
  local mode = vim.api.nvim_get_mode()["mode"]
  if mode == "i" then
    return theme.insert.section
  elseif mode == "R" then
    return theme.replace.section
  elseif mode == "t" then
    if section.section == "a" or section.section == "z" then
      return {bg = "#8F8F00", fg = "#ffffff"}
    elseif section.section == "b" or section.section == "y" then
      return {bg = "#373737", fg = "#8F8F00"}
    else
      return {bg = "#262626", fg = "#8F8F00"}
    end
  elseif mode == "c" then
    return theme.command.section
  elseif mode == "v" then
    return theme.visual.section
  end
  return theme.normal.section
end



ll.setup {
  options = {
    theme = theme,
  },
  sections = {
    lualine_a = {
      {
        print_mode,
        separator = {left = "", right=''},
        color = get_mode_color
      }
    },
    lualine_b = {
      {
        "branch",
        color = get_mode_color,
      },
      {
        "diff",
        color = get_mode_color,
      },
      {
        "diagnostics",
        color = get_mode_color,
      }
    },
    lualine_c = {
      {
        'filename',
        path = 1,                -- 0: Just the filename
                                 -- 1: Relative path
                                 -- 2: Absolute path
                                 -- 3: Absolute path, with tilde as the home directory

        symbols = {
          modified = '[*]',      -- Text to show when the file is modified.
          readonly = '[R]',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
        },
        color = get_mode_color
      }
    },
    lualine_x = {
      {
        "encoding",
        color = get_mode_color
      },
      {
        "fileformat",
        color = get_mode_color
      },
      {
        "filetype",
        color = get_mode_color
      }
    },
    lualine_y = {
      {
        print_player_status,
        color = get_mode_color
      },
      {
        'progress',
        color = get_mode_color
      },
      {
        'location',
        color = get_mode_color
      },
    },
    lualine_z = {
      {
        'datetime',
        style = '%H:%M',
        color = get_mode_color
      }
    }
  }
}


