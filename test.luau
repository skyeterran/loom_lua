loom = require("./loom")
random = require("./random")

-- Characters
narrator = loom.character{ name = nil }
skye = loom.character{ name = "Skye" }
zeelay = loom.character{ name = "Ze'elay" }

local loops = 0
function start()
    narrator("You wake up in what looks like an airline terminal.")

    loops = loops + 1
    if loops == 3 then
        narrator("Three times over? Seems excessive.")
        look_at_window()
    end

    skye(random.item{
        "Hello, there!",
        "Uh... hey.",
        "What's up?"
    })
    skye("Um, welcome to the space station.")
    check_bags()

    -- Restart the loop
    loom.jump(start)
end

function check_bags()
    local char = random.item{ skye, zeelay }
    char("May I check your bags?")
    loom.choice{
        ["yes"] = function()
            char("Oh, sweet!")
            char("I've dissolved them for you.")
        end,
        ["no"] = function()
            char("What? Why not?")
            char("You're on your own, then.")
        end,
    }
    char("What, no tip? Jackass.")
end

function look_at_window()
    narrator("You look at the portside window.")
    narrator("What is this place, really?")
end

loom.run(start)