loom = require("./loom")
random = require("./random")

-- Characters
narrator = loom.character{ name = nil }
skye = loom.character{ name = "Skye" }

local loops = 0
function start()
    narrator("You wake up in what looks like an airline terminal.")

    loops = loops + 1
    if loops == 3 then
        narrator("Three times over? Seems excessive.")
        look_at_window()
    end

    skye(random.choice{
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

function look_at_window()
    narrator("You look at the portside window.")
    narrator("What is this place, really?")
end

loom.run(start)