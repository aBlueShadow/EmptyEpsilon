#ifndef SINGLE_PILOT_SCREEN_H
#define SINGLE_PILOT_SCREEN_H

#include "gui/gui2_overlay.h"
#include "screenComponents/targetsContainer.h"
#include "gui/joystickConfig.h"

class GuiViewport3D;
class GuiMissileTubeControls;
class GuiRadarView;
class GuiKeyValueDisplay;
class GuiToggleButton;
class GuiRotationDial;
class GuiCombatManeuver;

class SinglePilotScreen : public GuiOverlay
{
private:
    GuiOverlay* background_crosses;

    GuiElement* warp_controls;
    GuiElement* jump_controls;
    GuiCombatManeuver* combat_maneuver;

    TargetsContainer targets;
    GuiRadarView* radar;
    GuiRotationDial* missile_aim;
    GuiMissileTubeControls* tube_controls;
    GuiToggleButton* lock_aim;
    bool drag_rotate;
public:
    SinglePilotScreen(GuiContainer* owner);

    virtual void onDraw(sp::RenderTarget& target) override;
    virtual void onUpdate() override;
};

#endif//SINGLE_PILOT_SCREEN_H
