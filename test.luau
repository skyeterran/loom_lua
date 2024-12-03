loom = require("./loom")

-- Characters
skye = loom.character{ name = "Skye" }

local gay = true
function start()
    skye("Hey, there!")
    skye("Um, welcome to the space station.")
    if gay then
        skye("Oh nice, youre gay!")
    else
        loom.jump(the_brig)
    end
    check_bags()

    -- Restart the loop
    loom.jump(start)
end

function check_bags()
    skye("May I check your bags?")
    loom.choice{
        ["yes"] = function()
            skye("Oh, sweet!")
            skye("I've dissolved them for you.")
        end,
        ["no"] = function()
            skye("What? Why not?")
            skye("You're on your own, then.")
        end,
    }
    skye("Guess that's sorted!")
end

function the_brig()
    skye("Well, now you're in space jail.")
    skye("Happy now?")
end

loom.run(start)