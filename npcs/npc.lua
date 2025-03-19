local class = require "lib.hump.class"
local Sprite = require "sprite"
local Interactable = require "interactable"

local NPC = class({
    __includes = { Sprite, Interactable },
    isTalking = false
})

-- TODO: add an image for dialogues
function NPC:init(pos, size, location, image)
    Sprite.init(self, pos, size, image)
    Interactable.init(self)

    self.location = location
end

return NPC
