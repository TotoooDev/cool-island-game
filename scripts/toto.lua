local Ero = require "lib.erogodic"

local hasChilled = false

return function ()
    return Ero(function ()
        name "Toto"
        msg "Hey dude. -- You want to chill with me on the beach?"

        name ""
        local hellyeah = option "Yes"
        local hellnah = option "Nope"
        menu "Chill with him on the beach?"
        if selection(hellyeah) then
            name "Toto"
            if not hasChilled then
                hasChilled = true

                msg "Cool. -- I like to come here sometimes. There's something about the sound of the waves that I find really relaxing. -- It makes me forget all the little problems in life y'know? It brings me peace. Just what I'm looking for."
                msg "I've been feeling the need to come here more and more often lately. -- It is what it is I guess."
                msg "Anyway. -- How are you doing?"

                name ""
                local fine = option "Fine!"
                local meh = option "Meh?"
                menu "How do you feel?"
                if selection(fine) then
                    name "Toto"
                    msg "Aah, that's great! I'm happy for you my dude. -- Enjoy your time here, it's a beautiful island."
                elseif selection(meh) then
                    name "Toto"
                    msg "Oh. -- I see."
                    msg "Y'know, whatever you're going through right now, just know you're not alone. -- We are always more loved than we will ever know. -- It could be your friend that has a little crush on you. -- You classmate or colleague whose day is brightened by your presence."
                    msg "The baker who thought you seemed like a really nice guy. -- Or even just a complete stranger that thought you looked good when you passed by them in the street. -- You'll never know how much you made them better."
                    msg "My point is, people love you. -- People are ready to listen to you, and to support you. -- You're loved, man. Please don't forget that."
                    msg "Anyway. I kinda yapped. -- I hope you heal from what you're going through."
                end
                msg "Have a great day my dude."
            else
                msg "Cool. Stay here however long you want."
            end

        elseif selection(hellnah) then
            name "Toto"
            msg "Alright, not a big deal. -- Have a great day. I hope you find whatever you've come here for."
        end

    end)
    :defineAttributes({
        "name"
    })
end
