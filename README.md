# galaxyline.nvim

galaxyline is a light-weight and **Super Fast** statusline plugin. Galaxyline
componentizes Vim's statusline by having a provider for each text area.

This means you can use the api provided by galaxyline to create the statusline
that you want, easily.

> **IMPORTANT**: galaxyline requires neovim 0.6 onwards

## Install

- packer.nvim

```lua
use({
  "NTBBloodbath/galaxyline.nvim",
  -- your statusline
  config = function()
    require("galaxyline.themes.eviline")
  end,
  -- some optional icons
  requires = { "kyazdani42/nvim-web-devicons", opt = true }
})
```

## Api

### Section Variables

The type of all of these section variables:

- `require("galaxyline").short_line_list` some special filetypes that show a
  short statusline like `LuaTree defx coc-explorer vista` etc.

- `require("galaxyline").section.left` the statusline left section.

- `require("galaxyline").section.mid` the statusline mid section.

- `require("galaxyline").section.right` the stautsline right section.

- `require("galaxyline").section.short_line_left` the statusline left section
  when filetype is in `short_line_list` and for inactive window

- `require("galaxyline").section.short_line_right` statusline right section when
  filetype is in `short_line_list` and for inactive window

### Component keyword

Example of a FileSize component in the left section:

```lua
require("galaxyline").section.left[1] = {
  FileSize = {
    provider = "FileSize",
    condition = function()
      return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    icon = "   ",
    highlight = { colors.green, colors.purple },
    separator = "",
    separator_highlight = { colors.purple, colors.darkblue },
  }
}
```

`provider` can be a string, function or table. When it's a string, it will match
the default provider group. If it doesn't match an existing group you will get
an error. You can also use multiple default providers in `provider`. If you are
using multiple then you must provide an array table for `provider`.

#### Default provider groups:

```lua
---- source provider functions
-- Code diagnostics
local diagnostic = require("galaxyline.providers.diagnostic")
-- Version control
local vcs = require("galaxyline.providers.vcs")
-- Core files information
local fileinfo = require("galaxyline.providers.fileinfo")
-- Extensions, aka plugins
local extension = require("galaxyline.providers.extensions")
-- Neovim highlighting
local colors = require("galaxyline.highlighting")
-- Buffer information, e.g. corresponding icon
local buffer = require("galaxyline.providers.buffer")
-- Search results
local search = require("galaxyline.providers.search")
-- Spacing
local whitespace = require("galaxyline.providers.whitespace")
-- Active language server information
local lspclient = require("galaxyline.providers.lsp")


---- Providers
BufferIcon  = buffer.get_buffer_type_icon
BufferNumber = buffer.get_buffer_number
FileTypeName = buffer.get_buffer_filetype
-- Git Provider
GitBranch = vcs.get_git_branch
DiffAdd = vcs.diff_add             -- support vim-gitgutter vim-signify gitsigns
DiffModified = vcs.diff_modified   -- support vim-gitgutter vim-signify gitsigns
DiffRemove = vcs.diff_remove       -- support vim-gitgutter vim-signify gitsigns
-- Search Provider
SearchResults = search.get_results,
-- File Provider
LineColumn = fileinfo.line_column
FileFormat = fileinfo.get_file_format
FileEncode = fileinfo.get_file_encode
FileSize = fileinfo.get_file_size
FileIcon = fileinfo.get_file_icon
FileName = fileinfo.get_current_file_name
LinePercent = fileinfo.current_line_percent
ScrollBar = extension.scrollbar_instance
VistaPlugin = extension.vista_nearest
-- Whitespace
Whitespace = whitespace.get_item
-- Diagnostic Provider
DiagnosticError = diagnostic.get_diagnostic_error
DiagnosticWarn = diagnostic.get_diagnostic_warn
DiagnosticHint = diagnostic.get_diagnostic_hint
DiagnosticInfo = diagnostic.get_diagnostic_info
-- LSP
GetLspClient = lspclient.get_lsp_client


---- Public libs
-- Get file icon color
require("galaxyline.providers.fileinfo").get_file_icon_color
-- Custom file icon with color
local my_icons = require("galaxyline.providers.fileinfo").define_file_icon()
my_icons['your file type here'] = { color code, icon}
-- If your filetype does is not defined in neovim  you can use file extensions
my_icons['your file ext  in here'] = { color code, icon}

---- built-in conditions
local condition = require("galaxyline.condition")
-- if buffer not empty return true else false
condition.buffer_not_empty
-- if winwidth(0)/ 2 > 40 true else false
condition.hide_in_width
-- find git root, you can use this to check if the project is a git workspace
condition.check_git_workspace()


---- built-in theme
local colors = require("galaxyline.themes.colors").default
--- Palette:
-- bg = "#202328"
-- fg = "#bbc2cf"
-- yellow = "#ECBE7B"
-- cyan = "#008080"
-- darkblue = "#081633"
-- green = "#98be65"
-- orange = "#FF8800"
-- violet = "#a9a1e1"
-- magenta = "#c678dd"
-- blue = "#51afef"
-- red = "#ec5f67"
```

> Do you want to use other themes than default or even make your own?
> Please refer to [themes.md](./docs/themes.md)!

You can also use the source of the provider function.

- `condition` is a function that must return a boolean. If it returns true then it
  will load the component.

- `icon` is a string that will be added to the head of the provider result.
  It can also be a function that returns a string.

- `highlight` is a string, function or table that can be used in two ways. The first is to pass three elements: the first element is `fg`, the second is `bg`, and the third is `gui`. The second method is to pass a highlight group as a string (such as `IncSearch`) that galaxyline will link to.

- `separator` is a string, function or table. notice that table type only work in mid section, It is not just a separator. Any statusline item can be
  defined here, like `%<`,`%{}`,`%n`, and so on.

- `separator_highlight` same as highlight

- `event` type is string. You configure a plugin's event that will reload the statusline.

## Awesome Show

- author: glepnir

![eviline](https://user-images.githubusercontent.com/41671631/110282770-05d0b100-801a-11eb-91b1-e30eacec9a1c.png)

- author: ChristianChiarulli

![](https://user-images.githubusercontent.com/29136904/97791654-2b9d0380-1bab-11eb-8133-d8160d3f72cd.png)

- author: BenoitPingris

![](https://user-images.githubusercontent.com/29386109/98808605-b3d99f00-241c-11eb-81dc-0caa852fe478.png)

- author: Th3Whit3Wolf

![](https://user-images.githubusercontent.com/48275422/101280897-c51b8e80-37c3-11eb-8bc3-be52fb4b6465.png)

- author: voitd

![](https://user-images.githubusercontent.com/60138143/103373409-8d131d00-4add-11eb-8dfc-40a37422f430.png)

You can find more custom galaxyline examples [here](https://github.com/glepnir/galaxyline.nvim/issues/12)

# License

MIT
