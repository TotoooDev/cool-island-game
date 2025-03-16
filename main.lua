local Timer = require "lib.hump.timer"
local Talkies = require "lib.talkies"

local Input = require "input"
local Map = require "map"
local Camera = require "camera"
local Player = require "player"
local Plan = require "plan"
local NPCRegistry = require "npcRegistry"
local PillarHandler = require "pillarHandler"

local map = Map("assets/images/map.bmp")
local player = Player(map)
local camera = Camera(player.pos)
local plan = Plan(player)
local npcRegistry = NPCRegistry(player)
local pillarHandler = PillarHandler(player)

function love.load()
    love.graphics.setBackgroundColor({ 0.5, 0.5, 0.5 })

    local font = love.graphics.newFont("assets/font/c64esque.ttf", 32)
    love.graphics.setFont(font)

    Talkies.talkSound = love.audio.newSource("assets/audio/blip.wav", "static")
    Talkies.typedNotTalked = false
    Talkies.font = font
    Talkies.indicatorCharacter = 'v'
    Talkies.optionCharacter = '>'
    Talkies.thickness = 1.0
    Talkies.rounding = 5.0
    Talkies.messageBorderColor = { 1.0, 1.0, 1.0, 1.0 }
end

function love.update(dt)
    Timer.update(dt)
    Talkies.update(dt)

    plan:update(dt)
    player:update(dt)

    camera.target = player.pos
    camera:update(dt)

    npcRegistry:update(dt, player.pos)
    pillarHandler:update(dt)
end

function love.draw()
    camera:attach()
    map:draw()
    player:draw()
    npcRegistry:draw()
    pillarHandler:draw()
    camera:detach()

    plan:draw()
    Talkies.draw()
end

function love.keypressed(key, scancode, isrepeat)
    if scancode == "w" then Input.up    = true end
    if scancode == "s" then Input.down  = true end
    if scancode == "a" then Input.left  = true end
    if scancode == "d" then Input.right = true end

    if scancode == "e" then Input.interact = true end
    if scancode == "q" then Input.plan = true end

    if scancode == "space" then Talkies.onAction() end
    if scancode == "up" then Talkies.prevOption() end
    if scancode == "down" then Talkies.nextOption() end
end

function love.keyreleased(key, scancode)
    if scancode == "w" then Input.up    = false end
    if scancode == "s" then Input.down  = false end
    if scancode == "a" then Input.left  = false end
    if scancode == "d" then Input.right = false end

    if scancode == "e" then Input.interact = false end
    if scancode == "q" then Input.plan = false end
end
