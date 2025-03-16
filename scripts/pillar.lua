local Ero = require "lib.erogodic"

return function ()
    return Ero(function ()
        name "Wow!"
        msg "You've found a pillar!"
    end)
    :defineAttributes({
        "name"
    })
end
