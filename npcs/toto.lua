local class = require "lib.hump.class"
local Vector = require "lib.hump.vector"
local NPC = require "npcs.npc"
local Script = require "scripts.toto"

local TotoNPC = class({ __includes = NPC })

function TotoNPC:init()
    NPC.init(self, Vector(100.0, 0.0), Vector(64.0, 64.0))
end

function TotoNPC:getScript()
    return Script()
end

return TotoNPC
