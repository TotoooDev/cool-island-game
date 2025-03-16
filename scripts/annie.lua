local Ero = require "lib.erogodic"

return function ()
    local portraitohno = love.graphics.newImage("assets/images/ohno.png")
    return Ero( function ()
        name "Annie"
        image(portraitohno)
        msg "Hi."
        image(portraitohno)
        msg "I don’t like sand. -- It’s coarse and rough and irritating, and it gets everywhere."
    end)
    :defineAttributes({
        "name",
        "image"
    })
end
