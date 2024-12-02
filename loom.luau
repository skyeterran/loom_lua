local module = {
    convo = nil,
}

function module.say(speaker, txt: string)
    --print(`Stack depth = {#module.convo}`)
    coroutine.yield{
        kind = "line",
        contents = txt,
        speaker = speaker,
    }
end

-- Runs a branch depending on the input key
function module.branch(fn)
    coroutine.yield{
        kind = "branch",
        contents = fn
    }
end

-- Like a branch, but presents the options first
function module.choose(options)
    coroutine.yield{
        kind = "choice",
        contents = options
    }
end

function module.run(fn: () -> ())
    coroutine.yield{
        kind = "run",
        contents = fn
    }
end

function module.jump(fn: () -> ())
    coroutine.yield{
        kind = "jump",
        contents = fn
    }
end

function module.start(fn)
    module.convo = { coroutine.create(fn) }
end

local function schedule(fn)
    table.insert(
        module.convo,
        coroutine.create(fn)
    )
end

function module.step(input: any?)
    local block = module.convo[#module.convo]
    local alive, value = coroutine.resume(block)
    if alive and value then
        if value.kind == "line" then
            print(`{value.speaker.name}: {value.contents}`)
        end
        if value.kind == "branch" then
            local chosen = value.contents[input]
            if chosen then
                schedule(chosen)
            end
            module.step()
        end
        if value.kind == "choice" then
            print("Choose one:")
            for k, _ in value.contents do
                print(`--> \"{k}\"`)
            end
            schedule(function()
                module.branch(value.contents)
            end)
        end
        if value.kind == "run" then
            schedule(value.contents)
            module.step()
        end
        if value.kind == "jump" then
            -- Replace the stack entirely
            module.convo = { coroutine.create(value.contents) }
            module.step()
        end
    else
        -- Pop finished path from stack
        table.remove(module.convo, #module.convo)
        module.step()
    end
end

return module