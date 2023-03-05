require 'mp.options'

local function set_loop()
    local duration = mp.get_property_native("duration")
    if not duration then
        return
    end

    local was_loop = mp.get_property_native("loop-file")

    local options = {autoloop_duration = 5}
    read_options(options)
    local autoloop_duration = options.autoloop_duration or 5

    if duration <= autoloop_duration and not was_loop then
        mp.set_property_native("loop-file", true)
        mp.set_property_bool("file-local-options/save-position-on-quit", false)
    elseif duration > autoloop_duration and was_loop then
        mp.set_property_native("loop-file", false)
    end
end

mp.register_event("file-loaded", set_loop)
