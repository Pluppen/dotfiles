local nl = require("null-ls")

nl.setup({
	sources = {
		nl.builtins.diagnostics.sqlfluff,
		nl.builtins.diagnostics.mypy.with({
			extra_args = function()
				local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
				return {
					"--ignore-missing-imports",
					"--check-untyped-defs",
					"--install-types",
					"--disallow-untyped-defs",
					"--python-executable",
					virtual .. "/bin/python3",
				}
			end,
		}),
		nl.builtins.formatting.sqlfluff,
		nl.builtins.formatting.black.with({
			extra_args = { "--line-length", 120 },
		}),
		nl.builtins.formatting.goimports,
		nl.builtins.formatting.stylua,
		nl.builtins.formatting.prettier,
		nl.builtins.formatting.ocamlformat,
		nl.builtins.formatting.clang_format,
	},
})
