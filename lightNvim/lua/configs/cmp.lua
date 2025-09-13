-- Tambahkan AI (Copilot) dan Laravel, dengan konfigurasi lebih kompleks dan fitur tambahan

dofile(vim.g.base46_cache .. "cmp")

local cmp = require "cmp"
local luasnip = require "luasnip"

-- Helper function for border style
local function border(hl_name)
  return {
    { "╭", hl_name }, { "─", hl_name },
    { "╮", hl_name }, { "│", hl_name },
    { "╯", hl_name }, { "─", hl_name },
    { "╰", hl_name }, { "│", hl_name },
  }
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local options = {
  completion = {
    completeopt = "menu,menuone,noinsert,noselect",
    keyword_length = 2,
    autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
  },

  experimental = {
    ghost_text = { hl_group = "CmpGhostText" },
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  formatting = {
    format = function(entry, vim_item)
      -- Add icons and source name
      local icons = {
        Copilot = "",
        nvim_lsp = "",
        luasnip = "",
        buffer = "",
        path = "",
        nvim_lua = "",
        laravel = "",
        nvim_lsp_signature_help = "",
      }
      local source = entry.source.name
      vim_item.kind = (icons[source] or "") .. " " .. vim_item.kind
      vim_item.menu = ({
        copilot = "[AI]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
        nvim_lua = "[Lua]",
        laravel = "[Laravel]",
        nvim_lsp_signature_help = "[Sig]",
      })[source] or ("[" .. source .. "]")
      return vim_item
    end,
  },

  window = {
    completion = {
      border = border "CmpBorder",
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
      scrollbar = true,
    },
    documentation = {
      border = border "CmpDocBorder",
      winhighlight = "Normal:CmpDoc",
    },
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = "copilot", group_index = 1, priority = 1200, max_item_count = 3 },
    { name = "nvim_lsp", group_index = 1, priority = 1000 },
    { name = "luasnip", group_index = 1, priority = 900 },
    { name = "nvim_lsp_signature_help", group_index = 1, priority = 800 },
    { name = "laravel", group_index = 1, priority = 700 },
    { name = "nvim_lua", group_index = 2, priority = 600 },
    { name = "buffer", group_index = 2, priority = 500, keyword_length = 3, max_item_count = 5 },
    { name = "path", group_index = 2, priority = 400 },
  }),

  sorting = {
    priority_weight = 2,
    comparators = {
      require("copilot_cmp.comparators").prioritize,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  -- Custom event for snippet choice
  enabled = function()
    local context = require("cmp.config.context")
    -- Disable completion in comments
    if context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment") then
      return false
    else
      return true
    end
  end,
}

return options
