math.randomseed(os.time())

local module = {
    number = math.random
}

function module.choice(table: {any})
    return table[math.random(1, #table)]
end

return module