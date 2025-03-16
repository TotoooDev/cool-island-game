local class = require "lib.hump.class"
local Vector = require "lib.hump.vector"
local Sprite = require "sprite"
local Interactable = require "interactable"
local Script = require "scripts.pillar"

local Pillar = class({
    __includes = { Sprite, Interactable },
    found = false
})

function Pillar:init(pos, pillarHandler)
    self.pillarHandler = pillarHandler

    Sprite.init(self, pos, Vector(64.0, 64.0))
    Interactable.init(self)
end

function Pillar:getScript()
    return Script()
end

return Pillar
