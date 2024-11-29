local module = {
    convo = nil,
    input = nil
}

function module.say(speaker, txt: string)
    --print(`Stack depth = {#module.convo}`)
    coroutine.yield{
        kind = "line",
        contents = txt,
        speaker = speaker,
    }
end

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

function module.step(input: any?)
    local block = module.convo[#module.convo]
    local alive, value = coroutine.resume(block)
    if alive and value then
        if value.kind == "line" then
            print(`{value.speaker.name}: {value.contents}`)
        end
        if value.kind == "choice" then
            for k, _ in value.contents do
                print(`--> \"{k}\"`)
            end
            -- TODO: This
        end
        if value.kind == "run" then
            -- Add path to stack
            table.insert(
                module.convo,
                coroutine.create(value.contents)
            )
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