local Timer = require "lib.hump.timer"
local Talkies = require "lib.talkies"

local Input = require "input"
local Camera = require "camera"
local Map = require "map"
local Player = require "player"
local Plan = require "plan"
local NPCRegistry = require "npcRegistry"
local PillarHandler = require "pillarHandler"
local TextureRegistry = require "textureRegistry"

local map
local player
local camera
local plan
local npcRegistry
local pillarHandler

function love.load()
    love.graphics.setBackgroundColor({ 0.5, 0.5, 0.5 })
    love.graphics.setDefaultFilter("nearest", "nearest")

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

    TextureRegistry.loadImages()
    map = Map("assets/images/beachnorth.bmp", Map.Location.beachNorth)
    player = Player(map)
    camera = Camera(player.pos, map)
    plan = Plan(player)
    npcRegistry = NPCRegistry(player, Map.Location.beachNorth)
    pillarHandler = PillarHandler(player)
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
    npcRegistry:draw()
    pillarHandler:draw()
    player:draw()
    camera:detach()

    plan:draw()
    Talkies.draw()

    if player.printPos then
        love.graphics.setColor({ 1.0, 1.0, 1.0 })
        love.graphics.print(player.pos.x .. ", " .. player.pos.y, 0, 0)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if scancode == "w" then Input.up    = true end
    if scancode == "s" then Input.down  = true end
    if scancode == "a" then Input.left  = true end
    if scancode == "d" then Input.right = true end

    if scancode == "e" then Input.interact = true end
    if scancode == "q" then Input.plan = true end
    if scancode == "r" then player:tryDig() end

    if scancode == "space" then Talkies.onAction() end
    if scancode == "up" or scancode == "w" then Talkies.prevOption() end
    if scancode == "down" or scancode == "s" then Talkies.nextOption() end

    if scancode == "n" and player.noClip ~= nil then player.noClip = not player.noClip end
    if key == "p" then player.printPos = not player.printPos end
end

function love.keyreleased(key, scancode)
    if scancode == "w" then Input.up    = false end
    if scancode == "s" then Input.down  = false end
    if scancode == "a" then Input.left  = false end
    if scancode == "d" then Input.right = false end

    if scancode == "e" then Input.interact = false end
    if scancode == "q" then Input.plan = false end
end
