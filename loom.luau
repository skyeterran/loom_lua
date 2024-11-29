local module = {
    convo = nil
}

function module.say(txt: string)
    coroutine.yield({
        kind = "line",
        contents = txt
    })
end

function module.act(fn: () -> ())
    coroutine.yield({
        kind = "act",
        contents = fn
    })
end

function module.start(fn)
    module.convo = { coroutine.create(fn) }
end

function module.step(input: any?)
    local block = module.convo[#module.convo]
    local alive, value = coroutine.resume(block)
    if alive and value then
        if value.kind == "line" then
            print(value.contents)
        end
        if value.kind == "act" then
            -- Add path to stack
            table.insert(
                module.convo,
                coroutine.create(value.contents)
            )
            module.step()
        end
    else
        -- Pop finished path from stack
        table.remove(module.convo, #module.convo)
        module.step()
    end
end

return module