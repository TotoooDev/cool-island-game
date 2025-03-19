local Ero = require "lib.erogodic"

local talkedTo = false

return function (found)
    return Ero( function ()
        if found then
            msg "Wow!-- You found something!"
        else
            msg "There is nothing here..."
        end
    end)
end
