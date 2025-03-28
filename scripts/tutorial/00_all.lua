-- Name: Run All
-- Description: All Station Tutorials. This cycles through all the stations. 
-- Type: Tutorial
require("utils.lua")
require("tutorialUtils.lua")


function tutorial_init()
    --Create the player ship
    tutorial_list = {
        mainscreenTutorial,
        radarTutorial,
        helmsTutorial,
        weaponsTutorial,
        engineeringTutorial,
        scienceTutorial,
        relayTutorial,
        --operationsTutorial, --Operations tutorial is a limited combination of sience and relay. Enable this and disable the science/relay tutorials if you want to give players this tutorial.
        endOfTutorial
    }

    startTutorial()
end

--[[ Radar explanation tutorial ]]
mainscreenTutorial = createSequence()
addToSequence(mainscreenTutorial, function() tutorial_switchViewToMainScreen() end)
addToSequence(mainscreenTutorial, _([[This is the main screen, which displays your ship and the surrounding space.
While you cannot move the ship from this screen, you can use it to visually identify objects.]]))


radarTutorial = createSequence()
addToSequence(radarTutorial, function() tutorial_switchViewToLongRange() end)
addToSequence(radarTutorial, _([[Welcome to the long-range radar. This radar can detect objects up to 30u from your ship, depicted at the radar's center. This radar allows you to quickly identify distant objects.]]))
addToSequence(radarTutorial, function() prev_object = Asteroid():setPosition(5000, 0):setSize(243) end)
addToSequence(radarTutorial, _([[This is an asteroid. Flying into an asteroid will damage your ship, so avoid hitting them.]]))
addToSequence(radarTutorial, function() prev_object:destroy() end)
addToSequence(radarTutorial, function() prev_object = Mine():setPosition(5000, 0) end)
addToSequence(radarTutorial, _([[The white dot is a mine. When you move near a mine, it explodes with a powerful 1u-radius blast. Striking a mine while your shields are down will surely destroy your ship.]]))
addToSequence(radarTutorial, function() prev_object:destroy() end)
addToSequence(radarTutorial, function() prev_object = SpaceStation():setTemplate("Medium Station"):setFaction("Human Navy"):setPosition(5000, 0) end)
addToSequence(radarTutorial, function() prev_object2 = SpaceStation():setTemplate("Large Station"):setFaction("Independent"):setPosition(5000, 5000) end)
addToSequence(radarTutorial, function() prev_object3 = SpaceStation():setTemplate("Huge Station"):setFaction("Kraylor"):setPosition(5000, -5000) end)
addToSequence(radarTutorial, _([[These are stations. Stations can be several different sizes and belong to different factions. Their color indicates whether the station is friendly (green), neutral (light blue), or hostile (red).]]))
addToSequence(radarTutorial, function() prev_object:destroy() end)
addToSequence(radarTutorial, function() prev_object2:destroy() end)
addToSequence(radarTutorial, function() prev_object3:destroy() end)
addToSequence(radarTutorial, function() prev_object = Nebula():setPosition(8000, 0) end)
addToSequence(radarTutorial, _([[The rainbow-colored cloud is a nebula. Nebulae block long-range sensors, preventing ships from detecting what's inside of them at distances of more than 5u. Sensors also cannot detect objects behind nebulae.]]))
addToSequence(radarTutorial, function() prev_object:destroy() end)
addToSequence(radarTutorial, function() prev_object = CpuShip():setFaction("Human Navy"):setTemplate("Phobos T3"):setPosition(5000, -2500):orderIdle():setScanned(true) end)
addToSequence(radarTutorial, function() prev_object2 = CpuShip():setFaction("Independent"):setTemplate("Phobos T3"):setPosition(5000, 2500):orderIdle():setScanned(true) end)
addToSequence(radarTutorial, function() prev_object3 = CpuShip():setFaction("Kraylor"):setTemplate("Phobos T3"):setPosition(5000, -7500):orderIdle():setScanned(true) end)
addToSequence(radarTutorial, function() prev_object4 = CpuShip():setFaction("Kraylor"):setTemplate("Phobos T3"):setPosition(5000, 7500):orderIdle():setScanned(false) end)
addToSequence(radarTutorial, _([[Finally, these are ships. They look like you on radar, and their attitude toward you is reflected by the same colors as stations. In addition to green, blue, and red, ships of unknown attitude appear as gray objects.]]))
addToSequence(radarTutorial, function() prev_object:destroy() end)
addToSequence(radarTutorial, function() prev_object2:destroy() end)
addToSequence(radarTutorial, function() prev_object3:destroy() end)
addToSequence(radarTutorial, function() prev_object4:destroy() end)
addToSequence(radarTutorial, _([[Next, we will look at the short-range radar.]]))
addToSequence(radarTutorial, function() tutorial_switchViewToTactical() end)
addToSequence(radarTutorial, _([[The short-range radar can detect objects up to 5u from your ship. It also depicts the range of your own beam weapons.
Your ship has 2 beam weapons aimed forward. Each type of ship has different beam weapon layouts, with different ranges and locations.]]))

helmsTutorial = createSequence()
addToSequence(helmsTutorial, function()
    tutorial_switchViewToScreen(0)
    tutorial_setMessageToTopPosition()
    resetPlayerShip()
    player:setJumpDrive(false)
    player:setWarpDrive(false)
    player:setCanCombatManeuver(false)
    player:setImpulseMaxSpeed(0);
    player:setRotationMaxSpeed(0);
end)
addToSequence(helmsTutorial, _([[This is the helms screen.
As the helms officer, you command your ship's movement in space.]]))
addToSequence(helmsTutorial, function() player:setImpulseMaxSpeed(90) end)
addToSequence(helmsTutorial, _([[Your primary controls are your impulse engines and maneuvering thrusters.
Your impulse controls are on the left side of the screen.

Raise your impulse level to 100% to fly forward right now.]]), function() return distance(player, 0, 0) > 1000 end)
addToSequence(helmsTutorial, function() player:setImpulseMaxSpeed(0):commandImpulse(0):setRotationMaxSpeed(10) end)
addToSequence(helmsTutorial, _([[Good. You now know how to move forward.

I've disabled your impulse engine for now. Next, let's rotate your ship.
Rotating the ship is easy. Simply press a heading on the radar screen to rotate your ship in that direction.
Try rotating to heading 200 right now.]]), function() return math.abs(player:getHeading() - 200) < 1.0 end)
addToSequence(helmsTutorial, function() player:setImpulseMaxSpeed(90) end)
addToSequence(helmsTutorial, function() prev_object = SpaceStation():setTemplate("Medium Station"):setFaction("Human Navy"):setPosition(0, -1500) end)
addToSequence(helmsTutorial, _([[Excellent!

Next up: docking. Docking with a station recharges your energy, repairs your hull, and allows the relay officer to request weapon refills. It can also be important for other mission-related events.
To dock, maneuver within 1u of a station and press the "Request Dock" button, from which point docking is fully automated.
Maneuver to the nearby station and request permission to dock.]]), function() return player:isDocked(prev_object) end)
addToSequence(helmsTutorial, _([[Now that you are docked, your movement is locked. As helms officer, there is nothing else you can do but undock, so do that now.]]), function() return not player:isDocked(prev_object) end)
addToSequence(helmsTutorial, function() prev_object:destroy() end)
addToSequence(helmsTutorial, function() prev_object = CpuShip():setFaction("Kraylor"):setTemplate("Flavia"):setPosition(-1500, 1500):orderIdle():setScanned(true):setHull(15):setShieldsMax(15) end)
addToSequence(helmsTutorial, function() player:commandSetTarget(prev_object) end)
addToSequence(helmsTutorial, _([[Ok, there are just a few more things that you need to know.
See the red arcs coming from your ship? Those are your beam weapons. As helms officer, it is your task to keep those beams on your target.
I've set up an stationary enemy ship as a target. Destroy it with your beam weapons. Note that at every shot, the corresponding firing arc will change color.]]), function() return not prev_object:isValid() end)
addToSequence(helmsTutorial, _([[Aggression is not always the solution, but boy, it is fun!

On to the next task: moving long distances.
There are two methods of moving long distances quickly. Depending on your ship, you either have a warp drive or a jump drive.
The warp drive moves your ship at high speed, while the jump drive instantly teleports your ship a great distance.]]))
addToSequence(helmsTutorial, function() player:setWarpDrive(true) end)
addToSequence(helmsTutorial, _([[First, let us try the warp drive.

It functions like the impulse drive but only propels your ship forward, and consumes energy at a much faster rate.
Use the warp drive to move more than 30u away from this starting point.]]), function() return distance(player, 0, 0) > 30000 end)
addToSequence(helmsTutorial, function() player:setWarpDrive(false):setJumpDrive(true):setPosition(0, 0) end)
addToSequence(helmsTutorial, _([[Next, let us demonstrate the jump drive.

To use the jump drive, point your ship in the direction where you want to jump, configure a distance to jump, and then initiate it. The jump occurs 10 seconds after you initiate. Use the jump drive to jump more than 30u from this starting point, in any direction.]]), function() return distance(player, 0, 0) > 30000 end)
addToSequence(helmsTutorial, _([[Notice how your jump drive needs to recharge after use.

This covers the basics of the helms officer.]]))

weaponsTutorial = createSequence()
addToSequence(weaponsTutorial, function()
    tutorial_switchViewToScreen(1)
    tutorial_setMessageToTopPosition()
    resetPlayerShip()
    player:setJumpDrive(false)
    player:setWarpDrive(false)
    player:setImpulseMaxSpeed(0)
    player:setRotationMaxSpeed(0)
end)

addToSequence(weaponsTutorial, _([[This is the weapons screen.
As the weapons officer, you are responsible for targeting beam weapons, loading and firing missile weapons, and controlling your shields.]]))
addToSequence(weaponsTutorial, function() prev_object = CpuShip():setFaction("Kraylor"):setTemplate("MT52 Hornet"):setPosition(700, 0):setRotation(0):orderIdle():setScanned(true) end)
addToSequence(weaponsTutorial, _([[Your most fundamental task is to target your ship's weapons.
Your beam weapons only fire at your selected target, and homing missiles travel toward your selected target.

Target the ship in front of you by pressing it.]]), function() return player:getTarget() == prev_object end)
addToSequence(weaponsTutorial, _([[Good! Notice that your beam weapons did not fire on this ship until you targeted it.

Next up: shield controls.]]))
addToSequence(weaponsTutorial, function() prev_object:destroy() end)
addToSequence(weaponsTutorial, function() prev_object = CpuShip():setFaction("Kraylor"):setTemplate("MT52 Hornet"):setAI("default"):setPosition(-700, 0):setRotation(0):orderAttack(player):setScanned(true) end)
addToSequence(weaponsTutorial, _([[As you might notice, you are being shot at. Do not worry, you cannot die right now.

You are taking damage, however, so enable your shields to protect yourself.]]), function()
    player:setHull(player:getHullMax())
    player:setSystemHealth("reactor", 1.0)
    player:setSystemHealth("beamweapons", 1.0)
    player:setSystemHealth("missilesystem", 1.0)
    player:setSystemHealth("maneuver", 1.0)
    player:setSystemHealth("impulse", 1.0)
    player:setSystemHealth("warp", 1.0)
    player:setSystemHealth("jumpdrive", 1.0)
    player:setSystemHealth("frontshield", 1.0)
    player:setSystemHealth("rearshield", 1.0)
    return player:getShieldLevel(1) < player:getShieldMax(1)
end)
addToSequence(weaponsTutorial, _([[Shields protect your ship from direct damage, but they cost extra energy to maintain, can take only a limited amount of damage, and are slow to recharge. Eventually, this enemy's attacks will get through your shields.

Disable your shields to continue.]]), function() return not player:getShieldsActive() end)
addToSequence(weaponsTutorial, function() prev_object:destroy() end)
addToSequence(weaponsTutorial, _([[While only a single button, your shields are vital for survival. They protect against all kinds of damage, including beam weapons, missiles, asteroids, and mines, so make them one of your primary priorities.

Next up, the real fun starts: missile weapons.]]))

addToSequence(weaponsTutorial, function()
    player:setWeaponStorageMax("homing", 1)
    player:setWeaponStorage("homing", 1)
    player:setWeaponTubeCount(1)
    prev_object = CpuShip():setFaction("Kraylor"):setTemplate("Flavia"):setPosition(3000, 0):setRotation(0):orderIdle():setScanned(true)
    prev_object:setHull(1):setShieldsMax(1) -- Make it die in 1 shot.
end)
addToSequence(weaponsTutorial, _([[You have 1 homing missile in your missile storage now, and 1 weapon tube.
You can load this missile into your weapon tube. Depending on your ship type, you might have more types of missiles and more weapon tubes.

Load this homing missile into the weapon tube by selecting the homing missile, and then pressing the load button for this tube. Note that it takes some time to load missiles into tubes.]]),
    function() return player:getWeaponTubeLoadType(0) == "homing" end)
addToSequence(weaponsTutorial, _([[Great! Now fire this missile by clicking on the tube.]]), function() return player:getWeaponTubeLoadType(0) == nil end)
addToSequence(weaponsTutorial, _([[Missile away!]]), function() return not prev_object:isValid() end)


addToSequence(weaponsTutorial, function() prev_object = CpuShip():setFaction("Kraylor"):setTemplate("Flavia"):setPosition(2000, -2000):setRotation(0):orderIdle():setScanned(true):setHull(1):setShieldsMax(1) end)
addToSequence(weaponsTutorial, function() tutorial_setMessageToBottomPosition() end)
addToSequence(weaponsTutorial, _([[BOOM! That was just firing straight ahead, but missiles also have a homing feature, so let's try that!

First, load a homing missile in the tube.
Next, target the enemy ship by pressing it to guide your homing missiles toward your selected target.
Then fire your missile!]]), function()
    if player:getWeaponStorage("homing") < 1 then
        player:setWeaponStorage("homing", 1)
    end
    return not prev_object:isValid()
end)
addToSequence(weaponsTutorial, _([[While not necessary against a stationary target, this homing ability can make all the difference against a moving target.]]))


addToSequence(weaponsTutorial, function() prev_object = CpuShip():setFaction("Kraylor"):setTemplate("Flavia"):setPosition(3000, -1500):setRotation(0):orderIdle():setScanned(true):setHull(1):setShieldsMax(1) end)
addToSequence(weaponsTutorial, _([[You can also manually aim missiles.

First, unlock your aim by pressing the [Lock] button above the radar view.
Load a missile to view your missile's trajectory.
Next, aim your missiles with the aiming dial surrounding the radar.
Point the aiming dial at the next ship and fire.]]), function()
    if player:getWeaponStorage("homing") < 1 then
        player:setWeaponStorage("homing", 1)
    end
    return not prev_object:isValid()
end)


addToSequence(weaponsTutorial, function() prev_object = CpuShip():setFaction("Kraylor"):setTemplate("Flavia"):setPosition(-1550, -1900):setRotation(0):orderIdle():setScanned(true):setHull(1):setShieldsMax(1) end)
addToSequence(weaponsTutorial, _([[Perfect aim! The next ship is behind you. Notice how it's out of reach when you try to aim manually and, if you only use the homing ability, the trajectory won't reach the enemy. Manually aiming and the missile's homing ability aren't mutually exclusive to one another. You can hit the ship if you put the two abilities together.

First, make sure your aim is unlocked and aim your missile as close to the enemy as you can.
Next, target the enemy ship by pressing it.
Then fire! The missile will first follow your manually-aimed trajectory, and then start homing in on the enemy.
]]), function()
    if player:getWeaponStorage("homing") < 1 then
        player:setWeaponStorage("homing", 1)
    end
    return not prev_object:isValid()
end)


addToSequence(weaponsTutorial, function() player:setWeaponStorage("homing", 0):setWeaponStorageMax("homing", 0) end)
addToSequence(weaponsTutorial, function() tutorial_setMessageToTopPosition() end)
addToSequence(weaponsTutorial, _([[In addition to homing missiles, your ship might have HVLIs, nukes, EMPs, and mines.
HVLI stands for "High Velocity Lead Impactor". They fire in straight lines and do not have homing abilities.
Nukes and EMPs also have homing abilities and have a 1u-radius blast and do more damage.
EMPs damage only shields, and thus are great for weakening heavily shielded enemies.]]))

engineeringTutorial = createSequence()
addToSequence(engineeringTutorial, function()
    tutorial_switchViewToScreen(2)
    tutorial_setMessageToTopPosition()
    resetPlayerShip()
end)
addToSequence(engineeringTutorial, _([[Welcome to engineering.
Engineering is split into two parts. The top part shows your ship's interior, including damage control teams stationed throughout.
The bottom part controls power and coolant levels of your ship's systems.]]))
addToSequence(engineeringTutorial, function() player:setWarpDrive(true) end)
addToSequence(engineeringTutorial, function() player:setSystemHeat("warp", 0.8) end)
addToSequence(engineeringTutorial, _([[First, we will explain your control over your ship's systems.
Each row on the bottom area of the screen represents one of your ship's system, and each system has a damage level, heat level, power level, and coolant level.

I've overheated your warp system. An overheating system can damage your ship. You can prevent this by putting coolant in your warp system. Select the warp system and increase the coolant slider.]]), function() return player:getSystemHeat("warp") < 0.05 end)
addToSequence(engineeringTutorial, function() player:setSystemHeat("impulse", 0.8) end)
addToSequence(engineeringTutorial, _([[I've also overheated the impulse system. As before, increase the system's coolant level to mitigate the effect. Note that the warp system's coolant level is automatically reduced to allow for coolant in the impulse system.

This is because you have a limited amount of coolant available to distribute this across your ship's systems.]]), function() return player:getSystemHeat("impulse") < 0.05 end)
addToSequence(engineeringTutorial, _([[Good! Next up: power levels.
You can manage each system's power level independently. Adding power to a system makes it perform more effectively, but also generates more heat, and thus requires coolant to prevent it from overheating and damaging the system.

Maximize the power to the front shield system.]]), function() return player:getSystemPower("frontshield") > 2.5 end)
addToSequence(engineeringTutorial, _([[The added power increases the amount of heat in the system.

Overpower the system until it overheats.]]), function() return player:getSystemHealth("frontshield") < 0.5 end)
addToSequence(engineeringTutorial, function() player:setSystemPower("frontshield", 0.0) end)
addToSequence(engineeringTutorial, function() player:commandSetSystemPowerRequest("frontshield", 0.0) end)
addToSequence(engineeringTutorial, _([[Note that as the system overheats, it takes damage. Because the system is damaged, it functions less effectively.

Systems can also take damage when your ship is hit while the shields are down.]]))
addToSequence(engineeringTutorial, function() tutorial_setMessageToBottomPosition() end)
addToSequence(engineeringTutorial, _([[In this top area, you see your damage control teams in your ship.]]))
addToSequence(engineeringTutorial, _([[The front shield system is damaged, as indicated by the color of this room's outline.

Select a damage control team from elsewhere on the ship by pressing it, then press on that room to initiate repairs.
(Repairs will take a while.)]]), function() player:commandSetSystemPowerRequest("frontshield", 0.0) return player:getSystemHealth("frontshield") > 0.9 end)
addToSequence(engineeringTutorial, function() tutorial_setMessageToTopPosition() end)
addToSequence(engineeringTutorial, _([[Good. Now you know your most important tasks. Next, we'll go over each system's function in detail.
Remember, each system performs better with more power, but performs less well when damaged. Your job is to keep vital systems running as well as you can.]]))
addToSequence(engineeringTutorial, _([[Reactor:

The reactor generates energy. Adding power to the reactor increases your energy generation rate.]]))
addToSequence(engineeringTutorial, _([[Beam Weapons:

Adding power to the beam weapons system increases their rate of fire, which causes them to do more damage.
Note that every beam you fire adds additional heat to the system.]]))
addToSequence(engineeringTutorial, _([[Missile System:

Increased missile system power lowers the reload time of weapon tubes.]]))
addToSequence(engineeringTutorial, _([[Maneuvering:

Increasing power to the maneuvering system allows the ship to turn faster. It also increases the recharge rate for the combat maneuvering system.]]))
addToSequence(engineeringTutorial, _([[Impulse Engines:

Adding power to the impulse engines increases your impulse flight speed.]]))
addToSequence(engineeringTutorial, _([[Warp Drive:

Adding power to the warp drive increases your warp drive flight speed.]]))
addToSequence(engineeringTutorial, _([[Jump Drive:

A higher-powered jump drive recharges faster and has a shorter delay before jumping.]]))
addToSequence(engineeringTutorial, _([[Shields:

Additional power in the shield system increases their rate of recharge, and decreases the amount of degradation your shields sustain when damaged.]]))
addToSequence(engineeringTutorial, _([[This concludes the overview of the engineering station. Be sure to keep your ship running in top condition!]]))

scienceTutorial = createSequence()
addToSequence(scienceTutorial, function()
    tutorial_switchViewToScreen(3)
    tutorial_setMessageToBottomPosition()
    resetPlayerShip()
end)
addToSequence(scienceTutorial, _([[Welcome, science officer.

You are the eyes of the ship. Your job is to supply the captain with information. From your station, you can detect and scan objects at a range of up to 30u.]]))
addToSequence(scienceTutorial, function() prev_object = SpaceStation():setTemplate("Medium Station"):setFaction("Human Navy"):setPosition(3000, -15000) end)
addToSequence(scienceTutorial, function() prev_object2 = CpuShip():setFaction("Human Navy"):setTemplate("Phobos T3"):setPosition(5000, -17000):orderIdle():setScanned(true) end)
addToSequence(scienceTutorial, _([[On this radar, you can select objects to get information about them.
I've added a friendly ship and a station for you to examine. Select them and notice how much information you can observe.
Heading and distance are of particular importance, as without these, the helms officer will be jumping in the dark.]]))
addToSequence(scienceTutorial, function() prev_object:destroy() end)
addToSequence(scienceTutorial, function() prev_object = CpuShip():setFaction("Kraylor"):setTemplate("Phobos T3"):setPosition(3000, -15000):orderIdle() end)
addToSequence(scienceTutorial, _([[I've replaced the friendly station with an unknown ship. Once you select it, notice that you know nothing about this ship.
To learn about it, you must scan it. Scanning requires you to match your scanner's frequency bands to your target's.
Scan this ship now.]]), function() return prev_object:isScannedBy(player) end)
addToSequence(scienceTutorial, _([[Good. Notice that you now know this ship is unfriendly. It might have been a friendly or neutral ship as well, but until you scanned it, you do not know.]]))
addToSequence(scienceTutorial, _([[Note that you have less information about this ship than the friendly ship. You must perform a deep scan of this ship to acquire more information.
A deep scan takes more effort and requires you to align 2 different frequency bands simultaneously.
Deep scan the enemy now.]]), function() return prev_object:isFullyScannedBy(player) end)
addToSequence(scienceTutorial, _([[Excellent. Notice that this took more time and concentration than the simple scan, so be careful to perform deep scans only when necessary or you could run out of time.]]))
addToSequence(scienceTutorial, function() prev_object:destroy() end)
addToSequence(scienceTutorial, function() prev_object2:destroy() end)
addToSequence(scienceTutorial, function() tutorial_setMessageToTopPosition() end)
addToSequence(scienceTutorial, _([[Next to the long-range radar, the science station can also access the science database.

In this database, you can look up details on things like ship types, weapons, and other objects.]]))
addToSequence(scienceTutorial, _([[Remember, your job is to supply information. Knowing the location and status of other ships is vital to your captain.

Without your information, the crew is mostly blind.]]))

relayTutorial = createSequence()
addToSequence(relayTutorial, function()
    tutorial_switchViewToScreen(4)
    tutorial_setMessageToBottomPosition()
    resetPlayerShip()
end)
addToSequence(relayTutorial, _([[Welcome to relay!

It is your job to communicate with stations and ships. You also have access to short-range radar data from friendly ships and stations, and can place navigational waypoints and launch scanning probes.]]))
addToSequence(relayTutorial, _([[Your first responsibility is to coordinate the ship's communications.

You can target any station or ship and attempt to communicate with it. Other ships can also attempt to contact you.]]))
addToSequence(relayTutorial, function()
    prev_object = SpaceStation():setTemplate("Medium Station"):setFaction("Human Navy"):setPosition(3000, -15000)
    prev_object:setCommsFunction(function()
        setCommsMessage(_("You successfully opened communications. Congratulations."));
        addCommsReply(_("Tell me more!"), function()
            setCommsMessage(_("Sorry, there's nothing more to tell you."))
        end)
        addCommsReply(_("Continue with the tutorial."), function()
            setCommsMessage(_("The tutorial will continue when you close communications with this station."))
        end)
    end)
end)
addToSequence(relayTutorial, _([[Open communications with the station near you to continue the tutorial.]]), function() return player:isCommsScriptOpen() end)
addToSequence(relayTutorial, function() tutorial_setMessageToTopPosition() end)
addToSequence(relayTutorial, _([[Now finish your talk with the station.]]), function() return not player:isCommsScriptOpen() end)
addToSequence(relayTutorial, function() tutorial_setMessageToBottomPosition() end)
addToSequence(relayTutorial, function() prev_object:destroy() end)
addToSequence(relayTutorial, _([[Depending on the scenario, you might have different options when communicating with stations.
They might inform you about new objectives and your mission progress, ask for backup, or resupply your weapons. This is all part of your responsibilities as relay officer.]]))
addToSequence(relayTutorial, function() prev_object = CpuShip():setFaction("Human Navy"):setTemplate("Phobos T3"):setPosition(20000, -20000):orderIdle():setCallSign("DMY-01"):setScanned(true):setCommsScript("") end)
addToSequence(relayTutorial, function() prev_object2 = CpuShip():setFaction("Human Navy"):setTemplate("Phobos T3"):setPosition(-24000, 2500):orderIdle():setScanned(true):setCommsScript(""):setShortRangeRadarRange(10000) end)
addToSequence(relayTutorial, function() prev_object3 = CpuShip():setFaction("Human Navy"):setTemplate("Phobos T3"):setPosition(-17000, -7500):orderIdle():setScanned(true):setCommsScript("") end)
addToSequence(relayTutorial, function() prev_object4 = CpuShip():setFaction("Human Navy"):setTemplate("Phobos T3"):setPosition(5400, 7500):orderIdle():setScanned(false):setCommsScript("") end)
addToSequence(relayTutorial, _([[Your station also includes this radar map.

On this map, you can detect objects within short-range radar range of all allied ships and stations. Everything else is invisible to you. This gives you a different view from the science officer, because you can scan the contents of nebulae.]]))
addToSequence(relayTutorial, _([[Finally, you control your ship's probes. Probes can expand your radar view. Launch a probe to the top right, toward the ship designated DMY-01.]]), function()
    for idx, obj in ipairs(getObjectsInRadius(20000, -20000, 5000)) do
        if obj.components.share_short_range_radar then
            return true
        end
    end
end)
addToSequence(relayTutorial, function() prev_object:destroy() end)
addToSequence(relayTutorial, function() prev_object2:destroy() end)
addToSequence(relayTutorial, function() prev_object3:destroy() end)
addToSequence(relayTutorial, function() prev_object4:destroy() end)
addToSequence(relayTutorial, _([[Probes can expand your sensory capabilities beyond your normal range and explore nebulae. However, you have a limited supply of them and can't replenish them until you to dock with a station.]]))


operationsTutorial = createSequence()
addToSequence(operationsTutorial, function()
    tutorial_switchViewToScreen(7)
    tutorial_setMessageToBottomPosition()
    resetPlayerShip()
end)
addToSequence(operationsTutorial, _([[Welcome, operations officer.

You are the eyes of the ship. Your job is to supply the captain with information. From your station, you can detect and scan objects at a range of up to 30u.]]))
addToSequence(operationsTutorial, function() prev_object = SpaceStation():setTemplate("Medium Station"):setFaction("Human Navy"):setPosition(3000, -15000) end)
addToSequence(operationsTutorial, function() prev_object2 = CpuShip():setFaction("Human Navy"):setTemplate("Phobos T3"):setPosition(5000, -17000):orderIdle():setScanned(true) end)
addToSequence(operationsTutorial, _([[On this radar, you can select objects to get information about them.
I've added a friendly ship and a station for you to examine. Select them and notice how much information you can observe.
Heading and distance are of particular importance, as without these, the helms officer will be jumping in the dark.]]))
addToSequence(operationsTutorial, function() prev_object:destroy() end)
addToSequence(operationsTutorial, function() prev_object = CpuShip():setFaction("Kraylor"):setTemplate("Phobos T3"):setPosition(3000, -15000):orderIdle() end)
addToSequence(operationsTutorial, _([[I've replaced the friendly station with an unknown ship. Once you select it, notice that you know nothing about this ship.
To learn about it, you must scan it. Scanning requires you to match your scanner's frequency bands to your target's.
Scan this ship now.]]), function() return prev_object:isScannedBy(player) end)
addToSequence(operationsTutorial, _([[Good. Notice that you now know this ship is unfriendly. It might have been a friendly or neutral ship as well, but until you scanned it, you do not know.]]))
addToSequence(operationsTutorial, _([[Note that you have less information about this ship than the friendly ship. You must perform a deep scan of this ship to acquire more information.
A deep scan takes more effort and requires you to align 2 different frequency bands simultaneously.
Deep scan the enemy now.]]), function() return prev_object:isFullyScannedBy(player) end)
addToSequence(operationsTutorial, _([[Excellent. Notice that this took more time and concentration than the simple scan, so be careful to perform deep scans only when necessary or you could run out of time.]]))
addToSequence(operationsTutorial, function() prev_object:destroy() end)
addToSequence(operationsTutorial, function() prev_object2:destroy() end)
addToSequence(operationsTutorial, function() tutorial_setMessageToTopPosition() end)
addToSequence(operationsTutorial, _([[Next to the long-range radar, the science station can also access the science database.

In this database, you can look up details on things like ship types, weapons, and other objects.]]))
addToSequence(operationsTutorial, _([[Remember, your job is to supply information. Knowing the location and status of other ships is vital to your captain.

Without your information, the crew is mostly blind.]]))
addToSequence(operationsTutorial, _([[Your second responsibility is to coordinate the ship's communications.

You can target any station or ship and attempt to communicate with it. Other ships can also attempt to contact you.]]))
addToSequence(operationsTutorial, function()
    prev_object = SpaceStation():setTemplate("Medium Station"):setFaction("Human Navy"):setPosition(3000, -15000)
    prev_object:setCommsFunction(function()
        setCommsMessage(_("You successfully opened communications. Congratulations."));
        addCommsReply(_("Tell me more!"), function()
            setCommsMessage(_("Sorry, there's nothing more to tell you."))
        end)
        addCommsReply(_("Continue with the tutorial."), function()
            setCommsMessage(_("The tutorial will continue when you close communications with this station."))
        end)
    end)
end)
addToSequence(operationsTutorial, _([[Open communications with the station near you to continue the tutorial.]]), function() return player:isCommsScriptOpen() end)
addToSequence(operationsTutorial, function() tutorial_setMessageToTopPosition() end)
addToSequence(operationsTutorial, _([[Now finish your talk with the station.]]), function() return not player:isCommsScriptOpen() end)
addToSequence(operationsTutorial, function() tutorial_setMessageToBottomPosition() end)
addToSequence(operationsTutorial, function() prev_object:destroy() end)
addToSequence(operationsTutorial, _([[Depending on the scenario, you might have different options when communicating with stations.
They might inform you about new objectives and your mission progress, ask for backup, or resupply your weapons. This is all part of your responsibilities as relay officer.]]))

endOfTutorial = createSequence()
addToSequence(endOfTutorial, function() tutorial_switchViewToMainScreen() end)
addToSequence(endOfTutorial, function() tutorial_setMessageToTopPosition() end)
addToSequence(endOfTutorial, _([[This concludes the tutorial. While we have covered the basics, there are more advanced features in the game that you might discover.]]))
