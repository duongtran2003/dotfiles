vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- FzfLua
vim.keymap.set('n', '<leader>F', '<cmd>FzfLua<cr>', { noremap = true })

-- Center cursor when jumping around
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })
vim.keymap.set('n', 'n', 'nzz', { noremap = true })
vim.keymap.set('n', 'N', 'Nzz', { noremap = true })
vim.keymap.set('i', '<C-u>', '<Nop>', { noremap = true })

vim.opt.backup = false

-- Single statusline
vim.o.laststatus = 3

-- :w? :W??
vim.api.nvim_create_user_command('W', function()
  vim.cmd 'w'
end, {})

-- Set tabsize
vim.api.nvim_create_user_command('ST', function(args)
  local size = args['args']
  vim.cmd('set tabstop=' .. size)
  vim.cmd('set shiftwidth=' .. size)
  vim.cmd('set softtabstop=' .. size)
  vim.cmd 'set expandtab'
end, { nargs = 1, desc = '[S]et [t]absize' })

-- Switch mode: dark <=> light
vim.api.nvim_create_user_command('SM', function(opts)
  vim.o.background = opts.args
  vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { link = 'TreesitterContext' })
end, {
  nargs = 1,
  complete = function()
    return { 'light', 'dark' }
  end,
})

vim.o.background = 'dark'
vim.o.winborder = ''

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

-- tab size
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.mouse = 'a'

vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = false

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 14

vim.opt.confirm = true

-- Fat cursor in all modes
vim.opt.guicursor = 'n-v-c-i:block'

-- term color
vim.opt.termguicolors = true

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- ESLint fix
vim.keymap.set('n', '<leader>lf', '<cmd>EslintFixAll<Cr>', { desc = '[L]int [f]ix' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<ScrollWheelUp>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<ScrollWheelDown>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<ScrollWheelLeft>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<ScrollWheelRight>', '<Nop>')

-- Inlay hints
vim.keymap.set('n', '<leader>th', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  if vim.lsp.inlay_hint.is_enabled() then
    vim.notify 'Inhay hint enabled'
  else
    vim.notify 'Inhay hint disabled'
  end
end, { desc = 'Toggle Inlay Hint' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--Disable TS on large file
vim.api.nvim_create_autocmd({ 'InsertLeave', 'InsertEnter' }, {
  pattern = '*',
  callback = function()
    if vim.api.nvim_buf_line_count(0) > 10000 then
      vim.cmd 'TSToggle highlight'
    end
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Session keymap
-- Load session
vim.keymap.set('n', '<leader>ps', function()
  require('persistence').load()
end, { desc = 'Load session' })

-- Select session
vim.keymap.set('n', '<leader>pS', function()
  require('persistence').select()
end, { desc = 'Select session' })

-- Load lass session
vim.keymap.set('n', '<leader>pl', function()
  require('persistence').load { last = true }
end, { desc = 'Load last session' })

-- stop Persistence => session won't be saved on exit
vim.keymap.set('n', '<leader>pd', function()
  require('persistence').stop()
end, { desc = 'Stop session' })

-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  {
    'NMAC427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {
        auto_cmd = true, -- Set to false to disable automatic execution
        override_editorconfig = true, -- Set to true to override settings set by .editorconfig
        filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
          'netrw',
          'tutor',
        },
        buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
          'help',
          'nofile',
          'terminal',
          'prompt',
        },
        on_tab_options = { -- A table of vim options when tabs are detected
          ['expandtab'] = false,
        },
        on_space_options = { -- A table of vim options when spaces are detected
          ['expandtab'] = true,
          ['tabstop'] = 'detected', -- If the option value is 'detected', The value is set to the automatically detected indent size.
          ['softtabstop'] = 'detected',
          ['shiftwidth'] = 'detected',
        },
      }
    end,
  },

  -- plenary
  { 'nvim-lua/plenary.nvim' },

  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    },
  },

  {
    'tpope/vim-fugitive',
  },

  {
    'sindrets/diffview.nvim',
  },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        -- add = { text = '│' },
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┇' },
      },
    },

    config = function()
      vim.keymap.set('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', { desc = '[G]itsigns [p]review hunk' })
      vim.keymap.set('n', '<leader>gt', '<cmd>Gitsigns toggle_current_line_blame<CR>', { desc = '[G]itsigns [t]oggle line blame' })
      vim.keymap.set('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', { desc = '[G]itsigns [r]eset hunk' })
      vim.keymap.set('n', '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>', { desc = '[G]itsigns [s]tage hunk' })

      require('gitsigns').setup {
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 500,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
      }
    end,
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 500,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>p', group = '[P]erssistence' },
      },
    },
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'nvim-java/nvim-java',
      { 'saghen/blink.cmp' },
      {
        'j-hui/fidget.nvim',
        opts = {},
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', '<cmd>FzfLua lsp_definitions<cr>', '[G]oto [D]efinition')
          map('gR', '<cmd>FzfLua lsp_references<cr>', '[G]oto [R]eferences')
          map('gI', '<cmd>FzfLua lsp_implementations<cr>', '[G]oto [I]mplementation')
          map('<leader>D', '<cmd>FzfLua lsp_typedefs<cr>', 'Type [D]efinition')
          map('<leader>ds', '<cmd>FzfLua lsp_document_symbols<cr>', '[D]ocument [S]ymbols')
          map('<leader>ws', '<cmd>FzfLua lsp_workspace_symbols<cr>', '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', '<cmd>FzfLua lsp_code_actions<CR>', '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', '<cmd>FzfLua lsp_declarations<cr>', '[G]oto [D]eclaration')
          map('<leader>dd', '<cmd>FzfLua lsp_document_diagnostics<cr>', '[D]ocument [d]iagnostic')
          map('<leader>wd', '<cmd>FzfLua lsp_workspace_diagnostics<cr>', '[W]orkspace [d]iagnostic')
          map('<leader>Q', '<cmd>FzfLua quickfix<cr>', '[Q]uickfix list')

          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })

      vim.diagnostic.config {
        virtual_text = false,
      }

      local baseCapabilities = require('blink.cmp').get_lsp_capabilities()
      local vue_language_server_path = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'
      local vue_plugin = {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
        configNamespace = 'typescript',
      }
      --

      local servers = {
        clangd = {},
        vue_ls = {
          filetypes = { 'vue', 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
          on_init = function(client)
            client.handlers['tsserver/request'] = function(_, result, context)
              local clients = vim.lsp.get_clients { bufnr = context.bufnr, name = 'vtsls' }
              if #clients == 0 then
                vim.notify('Could not found `vtsls` lsp client, vue_lsp would not work without it.', vim.log.levels.ERROR)
                return
              end
              local ts_client = clients[1]

              local param = unpack(result)
              local id, command, payload = unpack(param)
              ts_client:exec_cmd({
                title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
                command = 'typescript.tsserverRequest',
                arguments = {
                  command,
                  payload,
                },
              }, { bufnr = context.bufnr }, function(_, r)
                if not r then
                  return
                end
                local response_data = { { id, r.body } }
                ---@diagnostic disable-next-line: param-type-mismatch
                client:notify('tsserver/response', response_data)
              end)
            end
          end,
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
          capabilities = vim.tbl_deep_extend('force', baseCapabilities, {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          }),
        },
        -- angularls = {
        --   capabilities = baseCapabilities,
        -- },
        glsl_analyzer = {},
        cssls = {
          capabilities = baseCapabilities,
        },
        html = {
          capabilities = baseCapabilities,
        },
        css_variables = {
          capabilities = baseCapabilities,
        },
        cssmodules_ls = {

          capabilities = baseCapabilities,
        },
        eslint = {

          capabilities = baseCapabilities,
        },
        jsonls = {

          capabilities = baseCapabilities,
        },
        -- tailwindcss = {
        --   capabilities = baseCapabilities,
        -- },
        lua_ls = {
          capabilities = baseCapabilities,
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        prismals = {
          capabilities = baseCapabilities,
        },
        vtsls = {
          filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  vue_plugin,
                },
              },
            },
            typescript = {
              tsserver = {
                maxTsServerMemory = 4096,
              },
            },
          },
          capabilities = baseCapabilities,
        },
        intelephense = {
          capabilities = baseCapabilities,
        },
        gopls = {
          capabilities = baseCapabilities,
          settings = {
            gopls = {
              expandWorkspaceToModule = true,
              completeUnimported = true,
              usePlaceholders = true,
              gofumpt = true,
              staticcheck = true,

              analyses = {
                unusedparams = true,
                shadow = true,
              },

              directoryFilters = {
                '-.git',
                '-node_modules',
                '-bazel',
                '-build',
              },
            },
          },
        },
        roslyn = {
          capabilities = vim.tbl_deep_extend('force', baseCapabilities, {
            textDocument = {
              inlayHint = {
                dynamicRegistration = false,
              },
            },
          }),
          on_attach = function()
            print 'Roslyn attached'
          end,
          settings = {
            -- These settings control the scope of background diagnostics.
            ['csharp|background_analysis'] = {
              background_analysis = {
                -- Scope of the background analysis for .NET analyzer diagnostics.
                -- Expected values: openFiles, fullSolution, none
                dotnet_analyzer_diagnostics_scope = 'fullSolution',

                -- Scope of the background analysis for .NET compiler diagnostics.
                -- Expected values: openFiles, fullSolution, none
                dotnet_compiler_diagnostics_scope = 'fullSolution',
              },
            },

            -- These settings control the LSP code lens.
            ['csharp|code_lens'] = {
              -- Enable code lens references.
              -- Expected values: true, false
              dotnet_enable_references_code_lens = true,

              -- Enable tests code lens.
              -- Expected values: true, false
              dotnet_enable_tests_code_lens = false,
            },

            -- These settings control how the completions behave.
            ['csharp|completion'] = {
              -- Show regular expressions in completion list.
              -- Expected values: true, false
              dotnet_provide_regex_completions = false,

              -- Enables support for showing unimported types and unimported extension methods in completion lists.
              -- Expected values: true, false
              dotnet_show_completion_items_from_unimported_namespaces = true,

              -- Perform automatic object name completion for the members that you have recently selected.
              -- Expected values: true, false
              dotnet_show_name_completion_suggestions = true,
            },

            -- These settings control what inlay hints should be displayed.
            ['csharp|inlay_hints'] = {
              -- Show hints for implicit object creation.
              -- Expected values: true, false
              csharp_enable_inlay_hints_for_implicit_object_creation = true,

              -- Show hints for variables with inferred types.
              -- Expected values: true, false
              csharp_enable_inlay_hints_for_implicit_variable_types = true,

              -- Show hints for lambda parameter types.
              -- Expected values: true, false
              csharp_enable_inlay_hints_for_lambda_parameter_types = true,

              -- Display inline type hints.
              -- Expected values: true, false
              csharp_enable_inlay_hints_for_types = true,

              -- Show hints for indexers.
              -- Expected values: true, false
              dotnet_enable_inlay_hints_for_indexer_parameters = true,

              -- Show hints for literals.
              -- Expected values: true, false
              dotnet_enable_inlay_hints_for_literal_parameters = true,

              -- Show hints for 'new' expressions.
              -- Expected values: true, false
              dotnet_enable_inlay_hints_for_object_creation_parameters = true,

              -- Show hints for everything else.
              -- Expected values: true, false
              dotnet_enable_inlay_hints_for_other_parameters = true,

              -- Display inline parameter name hints.
              -- Expected values: true, false
              dotnet_enable_inlay_hints_for_parameter = true,

              -- Suppress hints when parameter names differ only by suffix.
              -- Expected values: true, false
              dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = false,

              -- Suppress hints when argument matches parameter name.
              -- Expected values: true, false
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = false,

              -- Suppress hints when parameter name matches the method's intent.
              -- Expected values: true, false
              dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false,
            },

            -- This setting controls how the language server should search for symbols.
            ['csharp|symbol_search'] = {
              -- Search symbols in reference assemblies.
              -- Expected values: true, false
              dotnet_search_reference_assemblies = true,
            },

            -- This setting controls how the language server should format code.
            ['csharp|formatting'] = {
              -- Sort using directives on format alphabetically.
              -- Expected values: true, false
              dotnet_organize_imports_on_format = true,
            },
          },
        },
      }

      require('mason').setup {
        PATH = 'prepend',
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry',
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for server_name, server_config in pairs(servers) do
        vim.lsp.config(server_name, server_config)
        vim.lsp.enable(server_name)
      end
    end,
  },

  {
    'saghen/blink.cmp',
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      { 'onsails/lspkind.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },

    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
        ['<A-l>'] = { 'snippet_forward', 'fallback' },
        ['<A-h>'] = { 'snippet_backward', 'fallback' },
        ['<S-Tab>'] = false,
        ['<Tab>'] = false,
      },

      cmdline = {
        completion = {
          menu = {
            auto_show = true,
          },
        },
      },

      completion = {
        keyword = {
          range = 'prefix',
        },
        menu = {
          auto_show = true,
          draw = {
            treesitter = { 'lsp' },
            components = {
              kind_icon = {
                text = function(ctx)
                  local lspkind = require 'lspkind'
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = require('lspkind').symbolic(ctx.kind, {
                      mode = 'symbol',
                    })
                  end

                  return icon .. ctx.icon_gap
                end,

                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },
            },
          },
        },
        accept = { auto_brackets = { enabled = true } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          window = {
            -- border = 'single',
          },
        },
        list = {
          selection = {
            auto_insert = false,
          },
        },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      signature = {
        enabled = true,
        window = {
          -- border = 'single',
        },
      },
    },
    opts_extend = { 'sources.default' },
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        vue = { 'prettier' },
        go = { 'golines' },
      },
    },
  },
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   config = function()
  --     require('nvim-treesitter.configs').setup {
  --       highlight = {
  --         enable = true,
  --         additional_vim_regex_highlighting = false,
  --       },
  --     }
  --     require('catppuccin').setup {
  --       flavour = 'auto', -- latte, frappe, macchiato, mocha
  --       background = { -- :h background
  --         light = 'latte',
  --         dark = 'mocha',
  --       },
  --       transparent_background = false, -- disables setting the background color.
  --       float = {
  --         transparent = false, -- enable transparent floating windows
  --         solid = false, -- use solid styling for floating windows, see |winborder|
  --       },
  --       show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
  --       term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
  --       dim_inactive = {
  --         enabled = false, -- dims the background color of inactive window
  --         shade = 'dark',
  --         percentage = 0.15, -- percentage of the shade to apply to the inactive window
  --       },
  --       no_italic = false, -- Force no italic
  --       no_bold = false, -- Force no bold
  --       no_underline = false, -- Force no underline
  --       styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
  --         comments = { 'italic' }, -- Change the style of comments
  --         conditionals = {},
  --         loops = {},
  --         functions = {},
  --         keywords = {},
  --         strings = {},
  --         variables = {},
  --         numbers = {},
  --         booleans = {},
  --         properties = {},
  --         types = {},
  --         operators = {},
  --         -- miscs = {}, -- Uncomment to turn off hard-coded styles
  --       },
  --       color_overrides = {},
  --       custom_highlights = {},
  --       default_integrations = true,
  --       auto_integrations = false,
  --       integrations = {
  --         cmp = true,
  --         gitsigns = true,
  --         nvimtree = true,
  --         treesitter = true,
  --         notify = false,
  --         mini = {
  --           enabled = true,
  --           indentscope_color = '',
  --         },
  --         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  --       },
  --     }
  --
  --     -- setup must be called before loading
  --     vim.cmd.colorscheme 'catppuccin'
  --   end,
  -- },
  -- {
  --   'tiagovla/tokyodark.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     local opts = {
  --       transparent_background = false, -- set background to transparent
  --       gamma = 1.00, -- adjust the brightness of the theme
  --       styles = {
  --         comments = { italic = true }, -- style for comments
  --         keywords = { italic = false }, -- style for keywords
  --         identifiers = { italic = false }, -- style for identifiers
  --         functions = {}, -- style for functions
  --         variables = {}, -- style for variables
  --       },
  --       custom_highlights = {} or function(highlights, palette)
  --         return {}
  --       end, -- extend highlights
  --       custom_palette = {} or function(palette)
  --         return {}
  --       end, -- extend palette
  --       terminal_colors = true, -- enable terminal colors
  --     }
  --     require('tokyodark').setup(opts) -- calling setup is optional
  --
  --     vim.cmd [[colorscheme tokyodark]]
  --
  --     local palette = {
  --       black = '#06080A',
  --       bg0 = '#11121D',
  --       bg1 = '#1A1B2A',
  --       bg2 = '#212234',
  --       bg3 = '#353945',
  --       bg4 = '#4A5057',
  --       bg5 = '#282C34',
  --       bg_red = '#FE6D85',
  --       bg_green = '#98C379',
  --       bg_blue = '#9FBBF3',
  --       diff_red = '#773440',
  --       diff_green = '#587738',
  --       diff_blue = '#2A3A5A',
  --       diff_add = '#1E2326',
  --       diff_change = '#262B3D',
  --       diff_delete = '#281B27',
  --       diff_text = '#1C4474',
  --       fg = '#A0A8CD',
  --       red = '#EE6D85',
  --       orange = '#F6955B',
  --       yellow = '#D7A65F',
  --       green = '#95C561',
  --       blue = '#7199EE',
  --       cyan = '#38A89D',
  --       purple = '#A485DD',
  --       grey = '#4A5057',
  --       none = 'NONE',
  --     }
  --
  --     vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = palette.bg3 })
  --     vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = palette.bg3 })
  --     vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = palette.bg3 })
  --     vim.api.nvim_set_hl(0, 'MatchParen', { bg = palette.bg3 })
  --     -- Indent line
  --     vim.api.nvim_set_hl(0, 'IblIndent', { fg = palette.bg1 })
  --     vim.api.nvim_set_hl(0, 'IblScope', { fg = palette.bg3 })
  --     --
  --     -- TS context
  --     vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = palette.bg0 })
  --     vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true, sp = palette.bg2 })
  --
  --     -- Current buffer
  --     vim.api.nvim_set_hl(0, 'BufferCurrent', { fg = palette.fg, bg = palette.bg0 })
  --     vim.api.nvim_set_hl(0, 'BufferCurrentSign', { fg = palette.bg_green, bg = palette.bg0 })
  --     vim.api.nvim_set_hl(0, 'BufferCurrentERROR', { fg = palette.bg_red, bg = palette.bg0 })
  --
  --     -- Visible buffer (on the same window with the current buffer)
  --     vim.api.nvim_set_hl(0, 'BufferVisible', { fg = palette.grey, bg = palette.bg1 })
  --     vim.api.nvim_set_hl(0, 'BufferVisibleSign', { fg = palette.bg_blue, bg = palette.bg1 })
  --     vim.api.nvim_set_hl(0, 'BufferVisibleERROR', { fg = palette.bg_red, bg = palette.bg1 })
  --
  --     -- Inactive buffer (buffer that is not in the window)
  --     vim.api.nvim_set_hl(0, 'BufferInactive', { fg = palette.bg4, bg = palette.bg1 })
  --     vim.api.nvim_set_hl(0, 'BufferInactiveSign', { fg = palette.bg1, bg = palette.bg1 })
  --     vim.api.nvim_set_hl(0, 'BufferInactiveERROR', { fg = palette.bg_red, bg = palette.bg1 })
  --
  --     vim.api.nvim_set_hl(0, 'NormalFloat', { bg = palette.bg2 })
  --     vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { link = 'NormalFloat' })
  --     vim.api.nvim_set_hl(0, 'BlinkCmpScrollbarGutter', { bg = palette.bg1 })
  --     vim.api.nvim_set_hl(0, 'BlinkCmpScrollbarThumb', { bg = palette.bg3 })
  --
  --     -- Alternate buffer (last modified buffer)
  --     -- vim.api.nvim_set_hl(0, 'BufferAlternate', { fg = palette.green, bg = palette.bg0 })
  --     -- vim.api.nvim_set_hl(0, 'BufferAlternateSign', { fg = palette.green, bg = palette.bg0 })
  --     -- vim.api.nvim_set_hl(0, 'BufferAlternateERROR', { fg = palette.bg_red, bg = palette.bg0 })
  --
  --     -- Modified buffer (last modified buffer)
  --     vim.api.nvim_set_hl(0, 'BufferCurrentMod', { fg = palette.green, bg = palette.bg0 })
  --     vim.api.nvim_set_hl(0, 'BufferCurrentModSign', { fg = palette.green, bg = palette.bg0 })
  --     vim.api.nvim_set_hl(0, 'BufferCurrentModERROR', { fg = palette.bg_red, bg = palette.bg0 })
  --
  --     vim.api.nvim_set_hl(0, 'BufferVisibleMod', { fg = palette.yellow, bg = palette.bg1 })
  --     vim.api.nvim_set_hl(0, 'BufferVisibleModSign', { fg = palette.yellow, bg = palette.bg1 })
  --     vim.api.nvim_set_hl(0, 'BufferVisibleModERROR', { fg = palette.bg_red, bg = palette.bg1 })
  --
  --     vim.api.nvim_set_hl(0, 'BufferInactiveMod', { fg = palette.yellow, bg = palette.bg1 })
  --     vim.api.nvim_set_hl(0, 'BufferInactiveModSign', { fg = palette.yellow, bg = palette.bg1 })
  --     vim.api.nvim_set_hl(0, 'BufferInactiveModERROR', { fg = palette.bg_red, bg = palette.bg1 })
  --   end,
  -- },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = false
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foreground = 'material'

      vim.cmd.colorscheme 'gruvbox-material'

      -- Cursor line
      vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = '#282828', fg = '#d4be98' })

      -- CurrentWord
      vim.api.nvim_set_hl(0, 'CurrentWord', { bg = '#3c3836' })

      -- Indent line
      vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#282828' })
      vim.api.nvim_set_hl(0, 'IblScope', { fg = '#3c3836' })
      --
      -- TS context
      vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = '#1d2021' })
      vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true, sp = '#3c3836' })

      -- Current buffer
      vim.api.nvim_set_hl(0, 'BufferCurrentSign', { fg = '#a9b665', bg = '#1d2021' })
      vim.api.nvim_set_hl(0, 'BufferCurrentERROR', { fg = '#ea6962', bg = '#1d2021' })

      -- Visible buffer (on the same window with the current buffer)
      vim.api.nvim_set_hl(0, 'BufferVisibleSign', { fg = '#d8a657', bg = '#141617' })
      vim.api.nvim_set_hl(0, 'BufferVisibleERROR', { fg = '#ea6962', bg = '#141617' })

      -- Inactive buffer (buffer that is not in the window)
      vim.api.nvim_set_hl(0, 'BufferInactiveSign', { fg = '#141617', bg = '#141617' })
      vim.api.nvim_set_hl(0, 'BufferInactiveERROR', { fg = '#ea6962', bg = '#141617' })

      -- Alternate buffer (last modified buffer)
      vim.api.nvim_set_hl(0, 'BufferAlternateSign', { fg = '#7daea3', bg = '#141617' })
      vim.api.nvim_set_hl(0, 'BufferAlternateERROR', { fg = '#ea6962', bg = '#141617' })

      vim.api.nvim_set_hl(0, 'SnacksNormal', { bg = '#282828' })
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Tree sitter context-awared comment plugin
      require('mini.comment').setup {
        options = {
          custom_commentstring = function()
            return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
          end,
        },
      }

      require('mini.pairs').setup()

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- require('mini.cursorword').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }
      --
      -- -- You can configure sections in the statusline by overriding their
      -- -- default behavior. For example, here we set the section for
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
      -- require('mini.statusline').setup()
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {},
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  -- Treesitter context
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.init
        line_numbers = true,
        multiline_threshold = 1, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 1, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
      -- vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { default = false, underline = false })
      vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { link = 'TreesitterContext' })
      -- vim.api.nvim_set_hl(0, 'TreesitterContext', { default = false, bg = '#1b1b1c' })
      vim.keymap.set('n', 'gu', function()
        require('treesitter-context').go_to_context(vim.v.count1)
      end, { silent = true, desc = '[G]o [u]p to context' })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ['html'] = {
            enable_close = true,
          },
        },
      }
    end,
  },

  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      require('barbar').setup {
        animation = false,
        hide = { extensions = false, inactive = false },
        icons = {
          -- Configure the base icons on the bufferline.
          -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
          buffer_index = false,
          buffer_number = false,
          button = '',
          -- Enables / disables diagnostic symbols
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
            [vim.diagnostic.severity.WARN] = { enabled = false },
            [vim.diagnostic.severity.INFO] = { enabled = false },
            [vim.diagnostic.severity.HINT] = { enabled = false },
          },
          filetype = {
            -- Sets the icon's highlight group.
            -- If false, will use nvim-web-devicons colors
            custom_colors = false,

            -- Requires `nvim-web-devicons` if `true`
            enabled = true,
          },
          separator = { left = '▍', right = '' },

          -- If true, add an additional separator at the end of the buffer list
          separator_at_end = false,

          -- Configure the icons on the bufferline when modified or pinned.
          -- Supports all the base icon options.
          modified = { button = '●' },
          pinned = { button = '', filename = true },

          -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
          preset = 'default',

          -- Configure the icons on the bufferline based on the visibility of a buffer.
          -- Supports all the base icon options, plus `modified` and `pinned`.
          alternate = { filetype = { enabled = false } },
          current = { buffer_index = false },
          inactive = {
            button = '',
          },
          visible = { modified = { buffer_number = false } },
        },
      }
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
      map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
      map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    name = 'lualine',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
    init = function()
      vim.g.qf_disable_statusline = true
    end,
    config = function()
      local tabStop = vim.opt.tabstop

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'gruvbox-material',
          component_separators = { left = '', right = '' },
          -- section_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = true,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {
            {
              'filename',
              path = 1,
            },
            {
              '%=',
            },
            {
              'vim.opt.tabstop:get()',
              icon = 'Tab: ',
            },
          },
          lualine_x = { 'encoding', 'filesize', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        winbar = {},
        tabline = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },

  -- Color highlighting
  {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      -- Ensure termguicolors is enabled if not already
      vim.opt.termguicolors = true
      require('nvim-highlight-colors').setup {
        render = 'virtual',
        virtual_symbol = '󱓻',
        enable_tailwind = true,
      }
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
      local hooks = require 'ibl.hooks'
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require('ibl').setup {
        indent = {
          char = '▏',
        },
        scope = {
          char = '▏',
          show_start = false,
          show_end = false,
        },
      }
    end,
  },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      image = {
        -- define these here, so that we don't need to load the image module
        formats = {
          'png',
          'jpg',
          'jpeg',
          'gif',
          'bmp',
          'webp',
          'tiff',
          'heic',
          'avif',
          'mp4',
          'mov',
          'avi',
          'mkv',
          'webm',
          'pdf',
        },
      },
      terminal = { enabled = false },
      bigfile = { enabled = true },
      notifier = { enabled = false },
      quickfile = { enabled = true },
      statuscolumn = {
        -- your statuscolumn configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      lazygit = {
        -- your lazygit configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        theme = {
          inactiveBorderColor = { fg = 'Comment' },
        },
      },
      scroll = {
        enabled = false,
        -- your scroll configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      words = {
        -- your words configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    },
    keys = {
      -- {
      --   '<leader>un',
      --   function()
      --     Snacks.notifier.hide()
      --   end,
      --   desc = 'Dismiss All Notifications',
      -- },
      {
        '<A-c>',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>gb',
        function()
          Snacks.git.blame_line()
        end,
        desc = 'Git Blame Line',
      },
      {
        '<leader>gB',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Browse',
      },
      {
        '<leader>gf',
        function()
          Snacks.lazygit.log_file()
        end,
        desc = 'Lazygit Current File History',
      },
      {
        '<leader>gl',
        function()
          Snacks.lazygit.log()
        end,
        desc = 'Lazygit Log (cwd)',
      },
      {
        '<leader>cR',
        function()
          Snacks.rename()
        end,
        desc = 'Rename File',
      },
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
      },
      {
        '<leader>z',
        function()
          Snacks.zen()
        end,
        desc = 'Toggle Zen Mode',
      },
      {
        '<leader>Z',
        function()
          Snacks.zen.zoom()
        end,
        desc = 'Toggle Zoom',
      },
    },
    init = function()
      local prev = { new_name = '', old_name = '' } -- Prevents duplicate events
      vim.api.nvim_create_autocmd('User', {
        pattern = 'NvimTreeSetup',
        callback = function()
          local events = require('nvim-tree.api').events
          events.subscribe(events.Event.NodeRenamed, function(data)
            if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
              data = data
              Snacks.rename.on_rename_file(data.old_name, data.new_name)
            end
          end)
        end,
      })
    end,
  },

  -- Float terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      local toggle_term = require 'toggleterm'
      toggle_term.setup {
        direction = 'horizontal',
        size = 24,
        open_mapping = [[<c-\>]],
        insert_mappings = false,
        start_in_insert = true,
        persist_mode = false,
      }
    end,
  },

  -- Lsp saga
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup {
        ui = {
          border = 'bold', -- Options: "single", "double", "rounded", "bold", "shadow"
          button = { '▐', '▌' },
        },
        symbol_in_winbar = {
          enable = false,
          color_mode = true,
        },
        lightbulb = { enable = false },
        code_action = {
          num_shortcut = true,
          show_server_name = true,
          extend_gitsigns = true,
        },
      }
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },

  -- File tree
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      vim.opt.termguicolors = true

      local WIDTH_RATIO = 0.2
      local HEIGHT_RATIO = 0.8
      local OFFSET = 3

      require('nvim-tree').setup {
        filters = {
          dotfiles = false,
        },
        view = {
          side = 'right',
          float = {
            enable = false,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * WIDTH_RATIO
              local window_h = screen_h * HEIGHT_RATIO
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)

              -- adjust for the offset
              local col_right_aligned = screen_w - window_w_int - OFFSET
              local row_offset = OFFSET - 3

              return {
                border = 'single',
                relative = 'editor',
                row = row_offset,
                col = col_right_aligned,
                width = window_w_int,
                height = window_h_int,
              }
            end,
            quit_on_focus_loss = true,
          },

          width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
          end,
        },
      }

      vim.keymap.set('n', '-', '<cmd>NvimTreeToggle<cr>', { noremap = true })
      vim.keymap.set('n', '=', '<cmd>NvimTreeFindFile<cr>', { noremap = true })
    end,
  },

  -- Folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  },

  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/snacks.nvim' },
    opts = {},
    config = function()
      local actions = require('fzf-lua').actions
      local snacks = require 'snacks.image'
      require('fzf-lua').setup {
        previewers = {
          builtin = {
            snacks_image = {
              enabled = true,
              render_inline = false,
            },
          },
        },
        grep = {
          rg_glob = true,
        },
        winopts = {
          border = 'single',
          row = 3,
          backdrop = 100,
          preview = {
            border = 'single',
          },
        },
        keymap = {
          builtin = {
            ['<C-d>'] = 'preview-page-down',
            ['<C-u>'] = 'preview-page-up',
          },
        },
        buffers = {
          actions = {
            ['alt-c'] = { fn = actions.buf_del, reload = true },
            ['ctrl-x'] = false,
          },
        },
      }
      vim.keymap.set('n', '<leader>sf', '<cmd>FzfLua files<cr>', { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader><leader>', '<cmd>FzfLua buffers --layout=reverse<cr>', { desc = '[S]earch Buffers' })
      vim.keymap.set('n', '<leader>sn', function()
        require('fzf-lua').files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
      vim.keymap.set('n', '<leader>/', '<cmd>FzfLua blines<cr>', { desc = '[S]earch current buffer' })
      vim.keymap.set('n', '<leader>s/', '<cmd>FzfLua lines<cr>', { desc = '[S]earch active buffer' })

      vim.keymap.set('n', '<leader>sg', '<cmd>FzfLua grep_project<cr>', { desc = '[S]earch [g]rep project' })
      vim.keymap.set('n', '<leader>lg', '<cmd>FzfLua live_grep<cr>', { desc = '[L]ive [g]rep project' })
    end,
  },

  {
    'mcauley-penney/visual-whitespace.nvim',
    config = true,
    opts = {
      highlight = { link = 'Visual' },
      space_char = '·',
      tab_char = '→',
      nl_char = '↲',
      cr_char = '←',
      enabled = true,
      excluded = {
        filetypes = {},
        buftypes = {},
      },
    },
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
      require('render-markdown').setup {
        completions = { blink = { enabled = true } },
        code = {
          width = 'block',
          left_pad = 0,
          right_pad = 0,
        },
      }
      vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = '#3c3836' })
    end,
  },
  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    config = function()
      local dropbar_api = require 'dropbar.api'
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    end,
  },
  {
    'esmuellert/vscode-diff.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
  },
  {
    'seblyng/roslyn.nvim',
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- "auto" | "roslyn" | "off"
      --
      -- - "auto": Does nothing for filewatching, leaving everything as default
      -- - "roslyn": Turns off neovim filewatching which will make roslyn do the filewatching
      -- - "off": Hack to turn off all filewatching. (Can be used if you notice performance issues)
      filewatching = 'roslyn',

      -- Optional function that takes an array of targets as the only argument. Return the target you
      -- want to use. If it returns `nil`, then it falls back to guessing the target like normal
      -- Example:
      --
      -- choose_target = function(target)
      --     return vim.iter(target):find(function(item)
      --         if string.match(item, "Foo.sln") then
      --             return item
      --         end
      --     end)
      -- end
      choose_target = nil,

      -- Optional function that takes the selected target as the only argument.
      -- Returns a boolean of whether it should be ignored to attach to or not
      --
      -- I am for example using this to disable a solution with a lot of .NET Framework code on mac
      -- Example:
      --
      -- ignore_target = function(target)
      --     return string.match(target, "Foo.sln") ~= nil
      -- end
      ignore_target = nil,

      -- Whether or not to look for solution files in the child of the (root).
      -- Set this to true if you have some projects that are not a child of the
      -- directory with the solution file
      broad_search = false,

      -- Whether or not to lock the solution target after the first attach.
      -- This will always attach to the target in `vim.g.roslyn_nvim_selected_solution`.
      -- NOTE: You can use `:Roslyn target` to change the target
      lock_target = false,

      -- If the plugin should silence notifications about initialization
      silent = false,
    },
  },
}, {
  ui = {
    icons = {},
  },
})
