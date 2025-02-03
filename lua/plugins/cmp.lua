return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  -- event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets
        -- This step is not supported in many windows environments
        -- Remove the below condition to re-enable on windows
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local cmp = require 'cmp'
    require('luasnip.loaders.from_vscode').lazy_load()
    local luasnip = require 'luasnip'
    luasnip.config.setup {}

    local kind_icons = {
      Text = '󰉿',
      Method = 'm',
      Function = '󰊕',
      Constructor = '',
      Field = '',
      Variable = '󰆧',
      Class = '󰌗',
      Interface = '',
      Module = '',
      Property = '',
      Unit = '',
      Value = '󰎠',
      Enum = '',
      Keyword = '󰌋',
      Snippet = '',
      Color = '󰏘',
      File = '󰈙',
      Reference = '',
      Folder = '󰉋',
      EnumMember = '',
      Constant = '󰇽',
      Struct = '',
      Event = '',
      Operator = '󰆕',
      TypeParameter = '󰊄',
    }

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noselect,noinsert' },
      window = {
           completion = cmp.config.window.bordered(),
           documentation = cmp.config.window.bordered(),
      },
     -- mapping = cmp.mapping.preset.insert {
     --   ['<C-j>'] = cmp.mapping.select_next_item(),       -- Select the [n]ext item
     --   ['<C-k>'] = cmp.mapping.select_prev_item(),       -- Select the [p]revious item
     --   ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept the completion with Enter.
     --   ['<C-c>'] = cmp.mapping.complete {},              -- Manually trigger a completion from nvim-cmp.
     mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),

        -- Select next/previous item with Tab / Shift + Tab
       -- ['<Tab>'] = cmp.mapping(function(fallback)
       --   if cmp.visible() then
       --     cmp.select_next_item()
       --   elseif luasnip.expand_or_locally_jumpable() then
       --     luasnip.expand_or_jump()
       --   else
       --     fallback()
       --   end
       -- end, { 'i', 's' }),
       -- ['<S-Tab>'] = cmp.mapping(function(fallback)
       --   if cmp.visible() then
       --     cmp.select_prev_item()
       --   elseif luasnip.locally_jumpable(-1) then
       --     luasnip.jump(-1)
       --   else
       --     fallback()
       --   end
       -- end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp'}, --, preselect = cmp.PreselectMode.None },
        { name = 'path' , preselect = cmp.PreselectMode.None },
        { name = 'luasnip' , preselect = cmp.PreselectMode.None },
        { name = 'buffer', keyword_length = 5 , preselect = cmp.PreselectMode.None },
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
          -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
          vim_item.menu = ({
            nvim_lsp = '[LSP]',
            luasnip = '[Snippet]',
            buffer = '[Buffer]',
            path = '[Path]',
          })[entry.source.name]
          return vim_item
        end,
      },
      experimental = {
	native_menu = false,
	ghost_text = true
	}
    }
  end,
}
--  {
--    'neovim/nvim-lspconfig',
--    dependencies = {
--      'hrsh7th/cmp-nvim-lsp',
--      'hrsh7th/cmp-buffer',
--      'hrsh7th/cmp-path',
--      'hrsh7th/cmp-cmdline',
--      'hrsh7th/nvim-cmp',
--      -- Snippet engine (vsnip in this case)
--      'hrsh7th/cmp-vsnip',
--      'hrsh7th/vim-vsnip',
--
--      -- Commented out alternative snippet engines
--      -- 'L3MON4D3/LuaSnip',
--      -- 'saadparwaiz1/cmp_luasnip',
--      -- 'echasnovski/mini.snippets',
--      -- 'abeldekat/cmp-mini-snippets',
--      -- 'SirVer/ultisnips',
--      -- 'quangnguyen30192/cmp-nvim-ultisnips',
--      -- 'dcampos/nvim-snippy',
--      -- 'dcampos/cmp-snippy',
--    },
--    config = function()
--      local cmp = require('cmp')
--
--      cmp.setup({
--        snippet = {
--          expand = function(args)
--            vim.fn["vsnip#anonymous"](args.body) -- For vsnip users
--            -- Alternative snippet engine expansions commented out
--            -- require('luasnip').lsp_expand(args.body)
--            -- require('snippy').expand_snippet(args.body)
--            -- vim.fn["UltiSnips#Anon"](args.body)
--            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
--          end,
--        },
--        window = {
--          -- completion = cmp.config.window.bordered(),
--          -- documentation = cmp.config.window.bordered(),
--        },
--        mapping = cmp.mapping.preset.insert({
--          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--          ['<C-f>'] = cmp.mapping.scroll_docs(4),
--          ['<C-Space>'] = cmp.mapping.complete(),
--          ['<C-e>'] = cmp.mapping.abort(),
--          ['<CR>'] = cmp.mapping.confirm({ select = true }),
--        }),
--        sources = cmp.config.sources({
--          { name = 'nvim_lsp' },
--          { name = 'vsnip' }, -- For vsnip users
--          -- Alternative sources commented out
--          -- { name = 'luasnip' },
--          -- { name = 'ultisnips' },
--          -- { name = 'snippy' },
--        }, {
--          { name = 'buffer' },
--        })
--      })
--
--      -- Cmdline setup for search (/ and ?)
--      cmp.setup.cmdline({ '/', '?' }, {
--        mapping = cmp.mapping.preset.cmdline(),
--        sources = {
--          { name = 'buffer' }
--        }
--      })
--
--      -- Cmdline setup for command mode
--      cmp.setup.cmdline(':', {
--        mapping = cmp.mapping.preset.cmdline(),
--        sources = cmp.config.sources({
--          { name = 'path' }
--        }, {
--          { name = 'cmdline' }
--        }),
--        matching = { disallow_symbol_nonprefix_matching = false }
--      })
--
--      -- LSP capabilities setup
--      local capabilities = require('cmp_nvim_lsp').default_capabilities()
--      
--      -- Replace <YOUR_LSP_SERVER> with the specific LSP server you're using
--      -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--        -- capabilities = capabilities
--      -- }
--    end
--  }
--}
--

