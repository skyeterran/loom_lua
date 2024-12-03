math.randomseed(os.time())

local module = {
    number = math.random
}

function module.item(table: {any})
    return table[math.random(1, #table)]
end

return module