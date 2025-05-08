return {

  -- LSP & null-ls setup for Python
  {
    "neovim/nvim-lspconfig",
    ft = { "python" },
    config = function()
      require("lspconfig").pyright.setup {}
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    ft = { "python" },
    config = function()
      local null_ls = require "null-ls"
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.diagnostics.ruff,
          null_ls.builtins.diagnostics.mypy,
        },
      }
    end,
  },

  -- Auto format on save
  {
    "nvimtools/none-ls.nvim", -- must match the one above
    ft = { "python" },
    config = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.py",
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end,
  },

  -- DAP for Python
  {
    "mfussenegger/nvim-dap",
    ft = { "python" },
    config = function()
      local dap = require "dap"

      -- Basic keybindings
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })

      -- Optional: setup Python adapter (e.g., debugpy)
      dap.adapters.python = {
        type = "executable",
        command = "python3",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return "python"
          end,
        },
      }
    end,
  },

  {
    "nvim-neotest/nvim-nio",
    lazy = true,
  },

  -- DAP UI (nice interface)
  {
    "rcarriga/nvim-dap-ui",
    ft = { "python" },
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio", -- <-- Required now
    },
    config = function()
      local dapui = require "dapui"
      local dap = require "dap"

      dapui.setup()

      -- Auto open and close dap-ui when debugging starts/ends
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Optional: Toggle UI with key
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI Toggle" })
    end,
  },
}
