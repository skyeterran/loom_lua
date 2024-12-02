loom = require("./loom")
say = loom.say
choose = loom.choose
run = loom.run
jump = loom.jump
step = loom.step

-- Charruners
local skye = { name = "Skye" }

local gay = true
function main()
    say(skye, "Hey, there!")
    say(skye, "Um, welcome to the space station.")
    if gay then
        say(skye, "Oh nice, youre gay!")
    end
    run(check_bags)

    -- Restart the loop
    jump(main)
end

function check_bags()
    say(skye, "May I check your bags?")
    choose{
        ["yes"] = function()
            say(skye, "Oh, sweet!")
            say(skye, "I've dissolved them for you.")
        end,
        ["no"] = function()
            say(skye, "What? Why not?")
            say(skye, "You're on your own, then.")
        end,
    }
    say(skye, "Guess that's sorted!")
end

loom.start(main)