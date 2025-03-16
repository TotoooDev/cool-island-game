local class = require "lib.hump.class"
local Talkies = require "lib.talkies"
local Script = require "scripts.default"

local Interactable = class({
    isInteracting = false
})

function Interactable:init()
    self.script = self:getScript()
end

function Interactable:getScript()
    return Script()
end

function Interactable:interact(oncomplete, config)
    local cool_config = config or {}
    cool_config.oncomplete = function ()
        oncomplete()
        self.isInteracting = false
    end

    if not self.isInteracting then
        self.isInteracting = true
        self:_nextMessage(oncomplete)
    end
end

function Interactable:_nextMessage(oncomplete)
    local node = self.script:next()
    self:_drawMessageNode(node, oncomplete)
end

function Interactable:_selectOption(selection, oncomplete)
    local node = self.script:select(selection)
    self:_drawMessageNode(node, oncomplete)
end

function Interactable:_drawMessageNode(node, oncomplete)
    if node == nil then
        oncomplete()
        self.isInteracting = false
        self.script = self:getScript()
        return
    end

    local config = {}
    if node.options then
        config.options = {}
        for i, opt in ipairs(node.options) do
            local onselect = function ()
                self:_selectOption(opt, oncomplete)
            end
            config.options[i] = { opt, onselect }
        end
    else
        config.image = node.image
        config.oncomplete = function ()
            self:_nextMessage(oncomplete)
        end
    end

    Talkies.say(node.name, node.msg, config)
end

return Interactable
