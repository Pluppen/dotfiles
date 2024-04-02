local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lsp-zero").extend_lspconfig()
local lsp = require("lsp-zero")

lsp.preset("recommended")

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<tab>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-f>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
    }),
})

lsp.set_preferences({
    sign_icons = {},
})

local function pwsh_splat(print_all_parameters)
    local word = vim.fn.expand("<cword>")
    local output
    if print_all_parameters then
        output = vim.fn.system("pwsh -c Out-SplatMandatoryParams -AllParameters -CmdName " .. word)
    else
        output = vim.fn.system("pwsh -c Out-SplatMandatoryParams -CmdName " .. word)
    end
    local lines = vim.fn.split(output, "\n")
    vim.api.nvim_del_current_line()
    vim.api.nvim_put({ "" }, "l", false, false)
    vim.api.nvim_put(lines, "l", true, true)
end

local function my_on_attach(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
        vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>vrr", function()
        vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("n", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, opts)
    if client.name == "powershell_es" then
        vim.keymap.set("n", "<C-s>m", function()
            pwsh_splat(false)
        end, opts)
        vim.keymap.set("n", "<C-s>a", function()
            pwsh_splat(true)
        end, opts)
        vim.keymap.set("i", "<C-s>p", function()
            local output = "[Parameter()] ["
            vim.api.nvim_put({ output }, "c", false, true)
        end)
        vim.keymap.set("i", "<C-s>m", function()
            local output = "[Parameter(Mandatory)] ["
            vim.api.nvim_put({ output }, "c", false, true)
        end)
        vim.keymap.set("n", "<C-s>f", function()
            local output = "function X {\nparam(\n\n)\n}"
            local lines = vim.fn.split(output, "\n")
            vim.api.nvim_put(lines, "l", true, false)
            vim.api.nvim_feedkeys("0fXcl", "n", true)
        end)
    end
end

lsp.on_attach(my_on_attach)

require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = {
        "lua_ls",
    },

    handlers = {
        lsp.default_setup,
    },
})

require("lsp_signature").setup({
    close_timeout = 2000,
    transparency = 80, -- opacity, not transparency
})

local mason_bin_dir = vim.fn.stdpath("data") .. "/mason/bin/"
local lspconfig = require("lspconfig")

-- lspconfig.powershell_es.setup({
--     bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
-- })

lspconfig.pyright.setup({})

-- lspconfig.pylsp.setup({
-- 	settings = {
-- 		pylsp = {
-- 			plugins = {
-- 				autopep8 = {
-- 					enabled = false,
-- 				},
-- 				pycodestyle = {
-- 					enabled = false,
-- 				},
-- 			},
-- 		},
-- 	},
-- })

lspconfig.azure_pipelines_ls.setup({
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                    "**/azure-pipeline*.y*l",
                    "azure-pipeline*.y*l",
                    "/*.azure*",
                    "Azure-Pipelines/**/*.y*l",
                    "Pipelines/*.y*l",
                    "template-*.y*l",
                    "deploy.*.y*l",
                    "build.*.y*l",
                    "*pipe*.y*l",
                    "**/template-*.y*l",
                    "**/deploy.*.y*l",
                    "**/build.*.y*l",
                    "**/*pipe*.y*l",
                },
            },
        },
    },
})

lspconfig.rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = true,
            inlayHints = {
                enable = true,
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                lifetimeElisionHints = {
                    enable = true,
                    useParameterNames = true,
                },
            },
            diagnostics = { enable = true },
            lens = {
                enable = true,
                debug = { enable = true },
            },
            highlightRelated = {
                references = { enable = true },
                exitPoints = { enable = true },
            },
            completion = {
                autoimport = { enable = true },
                autoselff = { enable = true },
            },
        },
    },
    on_attach = function(client, bufnr)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(bufnr, true)
            vim.api.nvim__buf_redraw_range(bufnr, 0, -1)
        end

        my_on_attach(client, bufnr)
    end,
})

lspconfig.bicep.setup({})

lspconfig.quick_lint_js.setup({})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {
        "*.go",
        "*.py",
        "*.lua",
        -- "*.yaml",
        -- "*.yml",
        "*.bicep",
        "*.rs",
        "*.sql",
        "*.ml",
    },
    command = "silent! lua vim.lsp.buf.format()",
})

lsp.setup({
    inlay_hints = true,
})
vim.diagnostic.config({
    virtual_text = true,
})
