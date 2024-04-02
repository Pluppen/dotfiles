local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Install your plugins here
return packer.startup(function(use)
    use("wbthomason/packer.nvim") -- Have packer manage itself

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.3",
        requires = { "nvim-lua/plenary.nvim" },
    })

    use({
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end,
    })

    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use("nvim-treesitter/playground")

    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "better-defaults",
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- LSP Support
            {
                "neovim/nvim-lspconfig",
                config = function()
                    return {
                        inlay_hints = { enabled = true },
                    }
                end,
            },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" },

            -- Linting & Formatting
            { "nvimtools/none-ls.nvim" },
        },
    })

    use({
        "Vonr/align.nvim",
        branch = "v2",
    })

    use({
        "ray-x/lsp_signature.nvim",
    })

    -- use('github/copilot.vim')

    use("APZelos/blamer.nvim")

    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install()"]()
        end,
    })

    use({
        "hedyhli/markdown-toc.nvim",
    })

    -- use({
    --     "huggingface/llm.nvim",
    --     config = function()
    --         require("llm").setup({
    --             model = "codellama:13b-code-q5_K_M",
    --             tokenizer = {
    --                 -- Important to switch this to the proper tokenizer when testing other stuff!
    --                 path = "",
    --             },
    --             backend = "ollama",
    --             url = "",
    --             tokens_to_clear = { " <EOT>" },
    --             request_body = {
    --                 options = {
    --                     num_predict = 200,
    --                     temperature = 0.16,
    --                     top_p = 0.17,
    --                 },
    --             },
    --             fim = {
    --                 enabled = true,
    --                 prefix = "<PRE> ",
    --                 suffix = " <SUF>",
    --                 middle = " <MID>",
    --             },
    --             debounce_ms = 1000,
    --             accept_keymap = "<C-j>",
    --             dismiss_keymap = "<C-k>",
    --             tls_skip_verify_insecure = true, -- TODO: set to false when I have let's encrypt set up
    --             lsp = {
    --                 bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
    --             },
    --             context_window = 16384,
    --             enable_suggestions_on_startup = false,
    --             enable_suggestions_on_files = "*",
    --         })
    --     end,
    -- })

    use({
        "nvim-lualine/lualine.nvim",
        optional = true,
    })

    -- use({
    -- 	"nvim-treesitter/nvim-treesitter-context",
    -- 	config = function()
    -- 		require("treesitter-context").setup({
    -- 			enable = true,
    -- 			max_lines = 0, -- <= 0 -> no limit
    -- 			min_window_height = 0, -- <= 0 -> no limit
    -- 			line_numbers = true,
    -- 			multiline_threshold = 20,
    -- 			trim_scope = "outer",
    -- 			mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- 			-- Separator between context and content. Should be a single character string, like '-'.
    -- 			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    -- 			separator = nil,
    -- 			zindex = 20,
    -- 		})
    -- 	end,
    -- })

    use({
        "wellle/context.vim",
    })

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
