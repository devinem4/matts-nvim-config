vim.api.nvim_create_user_command("Autopy", function()
  -- get current file name
  local file_path = vim.api.nvim_buf_get_name(0)
  -- create a new buffer
  local bufnr = vim.api.nvim_create_buf(false, true)
  local directory, filenm = string.match(file_path, "(.-)[/\\]([^/\\]+)$")
  -- update the buffer
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, { "Autopy running on BufNr", tostring(bufnr), filenm, directory })
  vim.api.nvim_command("vsplit")
  -- nvim_win_set_bufnr 0 = current window
  vim.api.nvim_win_set_buf(0, bufnr)
  print("starting autopy on BufNr", bufnr, filenm, directory)

  -- auto write on save
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("Autopy", { clear = true }),
    pattern = filenm,
    callback = function()
      vim.fn.jobstart({"python", filenm}, {
        cwd = directory,
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
          if data then
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
          end
        end,
        on_stderr = function(_, data)
          -- if there was no stdout, this will just append the error
          -- to the prior run. not ideal but ok for now
          if data then
            vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
          end
        end,
      })
    end,
  })
end, {})
