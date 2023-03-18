-- makes sure the language servers configured later with lspconfig are
-- actually available, and install them automatically if they're not
-- !! THIS MUST BE CALLED BEFORE ANY LANGUAGE SERVER CONFIGURATION
require("mason").setup()
require("mason-lspconfig").setup {
  -- automatically install language servers setup below for lspconfig
  automatic_installation = true
}

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- all of the below are referenced from the neovim nvim-lspconfig repo
-- github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- Setup the language servers so that they're available for our LSP client.
local lspconfig = require('lspconfig')

-- ansible 
lspconfig.ansiblels.setup{
   capabilities = capabilities
}

-- bash 
lspconfig.bashls.setup{
   capabilities = capabilities
}

-- docker 
lspconfig.dockerls.setup{
   capabilities = capabilities
}

-- json
lspconfig.jsonls.setup {
  capabilities = capabilities,
}


-- lua 
lspconfig.lua_ls.setup{
    settings = {
        Lua = {
            runtime = {
                -- version of Lua you're using (LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim`
                globals = {'vim'},
            },
            -- workspace = {
            --    -- Make the server aware of Neovim runtime
            --    library = vim.api.nvim_get_runtime_file("", true),
            -- },
            -- Do not send telemetry data containing a randomized but unique
            telemetry = {
                enable = false,
            },
        },
    },
}

-- markdown 
lspconfig.marksman.setup{
   capabilities = capabilities
}

-- python
lspconfig.jedi_language_server.setup{
   capabilities = capabilities
}

-- python - ruff linting
lspconfig.ruff_lsp.setup{}

-- terraform
lspconfig.terraformls.setup{
   capabilities = capabilities
}

-- Terraform linter that can act as lsp server.
-- Installation ref: https://github.com/terraform-linters/tflint#installation
lspconfig.tflint.setup{}

-- toml 
lspconfig.taplo.setup{
   capabilities = capabilities
}

-- vim -- will be removed when I finish converting everything to lua
lspconfig.vimls.setup{
   capabilities = capabilities
}

-- yaml - not sure if this is worth it yet
-- github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
lspconfig.yamlls.setup {
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.23.0-standalone-strict/all.json"] = "/*.k8s.yaml",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
            },
    }},
    capabilities = capabilities
}

-- change the diagnostic signs to be nerdfonts
local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Print diagnostics to message area
function PrintDiagnostics(opts, bufnr, line_nr, client_id)
  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
  opts = opts or {['lnum'] = line_nr}

  local line_diagnostics = vim.diagnostic.get(bufnr, opts)
  if vim.tbl_isempty(line_diagnostics) then return end

  local diagnostic_message = ""
  for i, diagnostic in ipairs(line_diagnostics) do
    diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
    print(diagnostic_message)
    if i ~= #line_diagnostics then
      diagnostic_message = diagnostic_message .. "\n"
    end
  end
  vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
end

vim.cmd [[ autocmd! CursorHold * lua PrintDiagnostics() ]]
