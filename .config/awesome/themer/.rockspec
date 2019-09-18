package = "awesome-themer"
version = "0.1"
source = {
   url = "..." -- We don't have one yet
}
description = {
    summary = "Theming tool for Awesome Window Manager",
   detailed = [[
      Helpful toolsfor creating & loading Awesome WM themes.
   ]],
   homepage = "https://dav3.co/projects/themer",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.4",
   "lua-cjson = 2.1.0-1", -- This particular verzion because latest is broken.
   "promise-lua = 0.4.0-1"
   -- If you depend on other rocks, add them here
}
build = {
   -- We'll start here.
}
