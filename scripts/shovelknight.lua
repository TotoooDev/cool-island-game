local Ero = require "lib.erogodic"
local Shovel = require "shovel"

local talkedTo = false

return function (player)
    local portraitohno = love.graphics.newImage("assets/images/ohno.png")
    return Ero( function ()
        if not talkedTo then
            name "The Shovel Gentleman"
            image(portraitohno)
            msg "HOWDY PARTNER!-- I'VE HEARD FROM A REPUTABLE SOURCE THAT YOU ARE CURRENTLY HUNTING A TREASURE, ON THIS VERY ISLAND!"
            msg "WELL, FEAR NO MORE! YOU ARE STANDING BEFORE THE GREAT,-- THE MAGNIFICIENT,-- SHOVEL GENTLEMAN!"

            name "You"
            image(portraitohno)
            msg "..."
            msg "..."
            msg "... What?"

            name "The Shovel Gentleman"
            image(portraitohno)
            msg "..."
            msg "Yeah, I mean, the knight thing was already taken so...-- Whatever."
            msg "So my brother Eric told me you might need a shovel huh?-- Well, you're in luck as I, in fact, own several of them.-- Eric told me I should let you borrow one of them."

            name ""
            image(nil)
            local kthanks = option "Ok. Thanks."
            local thefuckyoumean = option "What do you mean \"several of them\"?"
                menu ""
                if selection(kthanks) then
                    name "The Shovel Gentleman"
                    image(portraitohno)
                    msg "Alright, uh...-- Here is one. Take care of it please.-- My grandfather gave it to me before he passed away."
                    msg "ET EN FAIT LA BLAGUE C4EST QUE A LA FIN ON VA PETER LA PELLE LOL MDR"
                elseif selection(thefuckyoumean) then
                    name "The Shovel Gentleman"
                    image(portraitohno)
                    msg "Uh...-- Well, let's just say I am a bit of a collector.-- ANYWAY."
                    msg "Just take my shovel, and stop asking questions.-- Take care of it please.-- My grandfather gave it to me before he passed away."
                    msg "ET EN FAIT LA BLAGUE C4EST QUE A LA FIN ON VA PETER LA PELLE LOL MDR"
                end

            name ""
            image(nil)
            msg "You got a super cool shovel! Press <R> to try to dig through the sand!"

            player.shovel = Shovel()
            talkedTo = true
        else
            name "The Shovel Gentleman"
            image(portraitohno)
            msg "Uh... What do you want?-- Not a new shovel I hope."

            name ""
            image(nil)
            local wtf = option "Tell me more about your shovels."
            local nahimgood = option "Nah, I'm good."
            menu "What do you want?"
            if selection(wtf) then
                name "The Shovel Gentleman"
                image(portraitohno)
                msg "Uuuh...-- Um...-- I have nothing to tell you about my shovels.-- I am a perfectly normal man and can be trusted with my shovels."
            elseif selection(nahimgood) then
                name "The Shovel Gentleman"
                image(portraitohno)
                msg ("Phew!-- I thought you'd broken the shovel or something.")
            end
        end
    end)
    :defineAttributes({
        "name",
        "image"
    })
end
