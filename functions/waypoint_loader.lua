-- functions/waypoint_loader.lua

local waypoint_loader = {}

-- Importe as dependências necessárias aqui n tem nenhuma

-- Defina as variáveis necessárias (se não forem globais)
local helltide_tps = {
    {name = "Frac_Tundra_S", id = 0xACE9B, file = "menestad"},
    {name = "Scos_Coast", id = 0x27E01, file = "marowen"},
    {name = "Kehj_Oasis", id = 0xDEAFC, file = "ironwolfs"},
    {name = "Hawe_Verge", id = 0x9346B, file = "wejinhani"},
    {name = "Step_South", id = 0x462E2, file = "jirandai"}
}

-- Função auxiliar para carregar waypoints
local function load_waypoints(file)
    if file == "wejinhani" then
        return require("waypoints.wejinhani")
    elseif file == "marowen" then
        return require("waypoints.marowen")
    elseif file == "menestad" then
        return require("waypoints.menestad")
    elseif file == "jirandai" then
        return require("waypoints.jirandai")
    elseif file == "ironwolfs" then
        return require("waypoints.ironwolfs")
    else
        console.print("No waypoints loaded")
        return {}
    end
end

function waypoint_loader.check_and_load_waypoints()
    local world_instance = world.get_current_world()
    if not world_instance then
        console.print("Error: Unable to get world instance")
        return nil, nil
    end

    local zone_name = world_instance:get_current_zone_name()
    if not zone_name then
        console.print("Error: Unable to get zone name")
        return nil, nil
    end

    for _, tp in ipairs(helltide_tps) do
        if zone_name == tp.name then
            local waypoints = load_waypoints(tp.file)
            console.print("Loaded waypoints: " .. tp.file)
            return waypoints, tp.id
        end
    end
    
    console.print("No matching city found for waypoints")
    return nil, nil
end

return waypoint_loader