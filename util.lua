local Util = {}

function Util.aabbCollide(posA, sizeA, posB, sizeB)
    return
        posA.x + sizeA.x / 2  > posB.x + sizeB.x / 2 or
        posA.x - sizeA.x / 2  < posB.x + sizeB.x / 2 or
        posA.y + sizeA.y / 2  > posB.y + sizeB.y / 2 or
        posA.y - sizeA.y / 2  < posB.y + sizeB.y / 2
end

return Util
