return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,                      -- tinggi terminal
      open_mapping = [[<c-\>]],       -- default Ctrl+\ untuk toggle
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal",       -- muncul di bawah
      close_on_exit = true,
      shell = vim.o.shell,
    })

    -- bikin keymap toggle pakai <leader>tt
    vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
  end,
}
