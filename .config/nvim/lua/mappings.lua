require "nvchad.mappings"

local map = vim.keymap.set

map('n', 't', ':tabe<CR>')

-- why is this shit so slow :skull:
-- for i = 1, 69, 1 do
--     map('n', tostring(i), function()
--         vim.api.nvim_set_current_tabpage(i);
--     end)
-- end
map('n', tostring(1), function()
    vim.api.nvim_set_current_tabpage(1);
end)
map('n', tostring(2), function()
    vim.api.nvim_set_current_tabpage(2);
end)
map('n', tostring(3), function()
    vim.api.nvim_set_current_tabpage(3);
end)
map('n', tostring(4), function()
    vim.api.nvim_set_current_tabpage(4);
end)
map('n', tostring(5), function()
    vim.api.nvim_set_current_tabpage(6);
end)
map('n', tostring(6), function()
    vim.api.nvim_set_current_tabpage(7);
end)
map('n', tostring(7), function()
    vim.api.nvim_set_current_tabpage(8);
end)
map('n', tostring(8), function()
    vim.api.nvim_set_current_tabpage(9);
end)
map('n', tostring(9), function()
    vim.api.nvim_set_current_tabpage(10);
end)
map('n', tostring(10), function()
    vim.api.nvim_set_current_tabpage(11);
end)
map('n', tostring(11), function()
    vim.api.nvim_set_current_tabpage(12);
end)
