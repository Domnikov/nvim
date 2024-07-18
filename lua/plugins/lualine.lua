require('lualine').setup {
  options = {
    theme = 'vscode',
  },
  sections = {
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
        }
      }
    },
    lualine_y = {
      {
        'progress',
      },
      {
        'location',
      }
    },
    lualine_z = {
      {
        'datetime',
        style = '%H:%M'
      }
    }
  }
}


