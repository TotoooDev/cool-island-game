local class = require "lib.hump.class"
local Vector = require "lib.hump.vector"
local NPC = require "npcs.npc"
local Script = require "scripts.annie"

local AnnieNPC = class({ __includes = NPC })

function AnnieNPC:init()
    NPC.init(self, Vector(0.0, 100.0), Vector(64.0, 64.0))
end

function AnnieNPC:getScript()
    return Script()
end

return AnnieNPC
