--- A BlackHole is a piece of space terrain that pulls all nearby SpaceObjects within a 5U radius, including otherwise immobile objects like SpaceStations, toward its center.
--- A SpaceObject capable of taking damage is dealt an increasing amount of damage as it approaches the BlackHole's center.
--- Upon reaching the center, any SpaceObject is instantly destroyed even if it's otherwise incapable of taking damage.
--- AI behaviors avoid BlackHoles by a 2U margin.
--- In 3D space, a BlackHole resembles a black sphere with blue horizon.
--- Example: black_hole = BlackHole():setPosition(1000,2000)
function BlackHole()
    local e = createEntity()
    e.never_radar_blocked = {}
    e.gravity = {range=5000, damage=true}
    e.avoid_object = {range=7000}
    e.radar_signature = {gravity=0.9}
    e.radar_trace = {icon="radar/blackHole.png", min_size=0, max_size = 2048, radius=5000}
    --TODO: 3D billboard
    return e
end


--- A WormHole is a piece of space terrain that pulls all nearby SpaceObjects within a 5U radius, including otherwise immobile objects like SpaceStations, toward its center.
--- Any SpaceObject that reaches its center is teleported to another point in space.
--- AI behaviors avoid WormHoles by a 2U margin.
--- Example: wormhole = WormHole():setPosition(1000,1000):setTargetPosition(10000,10000)
function WormHole()
    local e = createEntity()
    local radius = 2500
    e.never_radar_blocked = {}
    e.gravity = {range=radius, damage=false}
    e.avoid_object = {range=radius*1.2}
    e.radar_signature = {gravity=0.9}
    e.radar_trace = {icon="radar/wormhole.png", min_size=0, max_size = 2048, radius=radius}
    --TODO: 3D billboard
    return e
end

local Entity = getLuaEntityFunctionTable()
--- Sets the target teleportation coordinates for SpaceObjects that pass through the center of this WormHole.
--- Example: wormhole:setTargetPosition(10000,10000)
function Entity:setTargetPosition(x, y)
    if self.gravity then self.gravity.wormhole_target = {x, y} end
    return self
end
--- Returns the target teleportation coordinates for SpaceObjects that pass through the center of this WormHole.
--- Example: wormhole:getTargetPosition()
function Entity:getTargetPosition()
    if self.gravity then return self.gravity.wormhole_target end
    return nil
end
--- Defines a function to call when this WormHole teleports a SpaceObject.
--- Passes the WormHole object and the teleported SpaceObject.
--- Example:
--- -- Outputs teleportation details to the console window and logging file
--- wormhole:onTeleportation(function(this_wormhole,teleported_object) print(teleported_object:getCallSign() .. " teleported to " .. this_wormhole:getTargetPosition()) end)
function Entity:onTeleportation(callback)
    if self.gravity then self.gravity.on_teleportation = callback end
    return self
end