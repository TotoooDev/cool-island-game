local class = require "lib.hump.class"
local Interactable = require "interactable"
local Script = require "scripts.shovel"

local Shovel = class({ __includes = Interactable,
    foundSomething = false
})

function Shovel:init()
    Interactable.init(self)
end

function Shovel:getScript()
    return Script(self.foundSomething)
end

return Shovel
