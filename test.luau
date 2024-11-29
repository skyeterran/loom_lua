loom = require("./loom")
say = loom.say
act = loom.act
jump = loom.jump

local gay = true
function main()
    say("A")
    say("B")
    if gay then
        say("Nice lol")
    end
    say("C")
    act(function()
        say("  D")
        say("  E")
        say("  F")
        act(function()
            say("    G")
            say("    H")
            say("    I")
        end)
    end)
    say("K")
    say("L")
    say("M")
    act(function()
        say("  N")
        say("  O")
        say("  P")
    end)

    -- Restart the loop
    jump(main)
end

loom.start(main)