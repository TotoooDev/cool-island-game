local class = require "lib.hump.class"
local Input = require "input"
local TotoNPC = require "npcs.toto"
local AnnieNPC = require "npcs.annie"
local ShovelKnightNPC = require "npcs.shovelknight"

local NPCRegistry = class({
    interactionRange = 100.0,
    interactedNpc = nil
})

function NPCRegistry:init(player, location)
    self.player = player
    self.npcs = {
        TotoNPC(),
        AnnieNPC(),
        ShovelKnightNPC(player)
    }
    self.activeNpcs = {}
    for _, npc in ipairs(self.npcs) do
        if npc.location == location then
            table.insert(self.activeNpcs, npc)
        end
    end
end

function NPCRegistry:update(dt)
    self.interactedNpc = nil
    for _, npc in ipairs(self.activeNpcs) do
        if npc.pos:dist(self.player.pos) < self.interactionRange then
            self.interactedNpc = npc
            break
        end
    end
end

function NPCRegistry:draw()
    for _, npc in ipairs(self.activeNpcs) do
        npc:draw()
    end

    if self.interactedNpc ~= nil then
        love.graphics.setColor({ 1.0, 1.0, 1.0 })
        love.graphics.print("Interact!", self.interactedNpc.pos.x - 50, self.interactedNpc.pos.y - 100)
        if Input.interact then
            self.player.canMove = false
            self.interactedNpc:interact(function () self.player.canMove = true end)
        end
    end
end

return NPCRegistry
