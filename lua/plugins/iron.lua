return{
  "hkupty/iron.nvim",
  config = function()
    local iron = require("iron.core")
    iron.setup({
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = { "zsh" },
          },
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = require("iron.view").bottom(40),
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        send_motion = "<space>ir",
        visual_send = "<space>is",
        send_file = "<space>if",
        send_line = "<space>il",
        send_mark = "<space>im",
        mark_motion = "<space>imm",
        mark_visual = "<space>imv",
        remove_mark = "<space>imr",
        cr = "<space>i<cr>",
        interrupt = "<space>i<space>",
        exit = "<space>iq",
        clear = "<space>ic",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    })

    -- iron also has a list of commands, see :h iron-commands for all available commands
    -- vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
    -- vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
    -- vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
    -- vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
  end,
}
