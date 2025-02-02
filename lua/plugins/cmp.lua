return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
      
      -- Snippet engine (vsnip in this case)
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',

      -- Commented out alternative snippet engines
      -- 'L3MON4D3/LuaSnip',
      -- 'saadparwaiz1/cmp_luasnip',
      -- 'echasnovski/mini.snippets',
      -- 'abeldekat/cmp-mini-snippets',
      -- 'SirVer/ultisnips',
      -- 'quangnguyen30192/cmp-nvim-ultisnips',
      -- 'dcampos/nvim-snippy',
      -- 'dcampos/cmp-snippy',
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For vsnip users
            -- Alternative snippet engine expansions commented out
            -- require('luasnip').lsp_expand(args.body)
            -- require('snippy').expand_snippet(args.body)
            -- vim.fn["UltiSnips#Anon"](args.body)
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- For vsnip users
          -- Alternative sources commented out
          -- { name = 'luasnip' },
          -- { name = 'ultisnips' },
          -- { name = 'snippy' },
        }, {
          { name = 'buffer' },
        })
      })

      -- Cmdline setup for search (/ and ?)
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Cmdline setup for command mode
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      -- LSP capabilities setup
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Replace <YOUR_LSP_SERVER> with the specific LSP server you're using
      require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
        capabilities = capabilities
      }
    end
  }
}


