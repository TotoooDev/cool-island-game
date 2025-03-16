local class = require "lib.hump.class"
local Vector = require "lib.hump.vector"
local Pillar = require "pillar"
local Input = require "input"

local PillarHandler = class({
    interactionRange = 100.0,
    interactedPillar = nil,
    interactedPillarIndex = nil
})

function PillarHandler:init(player)
    self.player = player
    self.pillars = {
        Pillar(Vector( 150.0,  150.0), self),
        Pillar(Vector(-150.0,  150.0), self),
        Pillar(Vector( 150.0, -150.0), self),
        Pillar(Vector(-150.0, -150.0), self)
    }
end

function PillarHandler:update(dt)
    self.interactedPillar = nil
    self.interactedPillarIndex = nil
    for i, pillar in ipairs(self.pillars) do
        if pillar.pos:dist(self.player.pos) < self.interactionRange then
            self.interactedPillar = pillar
            self.interactedPillarIndex = i
            break
        end
    end
end

function PillarHandler:draw()
    for _, pillar in ipairs(self.pillars) do
        pillar:draw()
    end

    if self.interactedPillar ~= nil then
        love.graphics.setColor({ 1.0, 1.0, 1.0 })
        love.graphics.print("Interact!", self.interactedPillar.pos.x - 50, self.interactedPillar.pos.y - 100)
        if Input.interact then
            self.player.canMove = false
            self.interactedPillar:interact(function ()
                self.player.canMove = true
                table.remove(self.pillars, self.interactedPillarIndex)
                end
            )
        end
    end
end

return PillarHandler
