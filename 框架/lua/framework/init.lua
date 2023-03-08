require "framework.functions"
require "framework.time"
require "framework.update_callback"
require "framework.timer"

local Dev = require "framework.dev"
if Dev.HasXMLib() then
    require "framework.ui.jass_ext"
end
