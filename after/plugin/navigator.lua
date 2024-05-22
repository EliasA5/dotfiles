

--    <ctrl-h> => Left
--    <ctrl-j> => Down
--    <ctrl-k> => Up
--    <ctrl-l> => Right
--    <ctrl-\> => Previous split

vim.keymap.set({'n', 't'}, '<C-h>', '<CMD>NavigatorLeft<CR>')
vim.keymap.set({'n', 't'}, '<C-l>', '<CMD>NavigatorRight<CR>')
vim.keymap.set({'n'}, '<C-j>', '<CMD>NavigatorDown<CR>')
vim.keymap.set({'n'}, '<C-k>', '<CMD>NavigatorUp<CR>')
-- vim.keymap.set({'n', 't'}, '<ctrl-\>', '<CMD>NavigatorPrevious<CR>')

