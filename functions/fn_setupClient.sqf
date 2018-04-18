#include "common_defines.inc"
#define ADD_REPAIR_ACTION(NAME,HITPOINT,ORDER) player addAction [\
    NAME,\
    TT_fnc_repair,\
    HITPOINT,\
    ORDER,\
    false, false,"",\
    QUOTE(vehicle _this != _this && (vehicle _this) getHitPointDamage HITPOINT >= 0.9),\
    -1\
]

if !(hasInterface) exitWith {};
[{player == player}, {
    if (didJIP) then {
        player setDamage 1;
    } else {
        // Variables:
        TT_secondsLeft = 10;
        TT_eventsArray = [];
        acex_killTracker_outputText = "None";

        // Add Event Handlers:
        ["TT_kill", {
            params ["_name", "_killInfo"];
            TT_eventsArray pushBack format ["Killed: %1 %2", _name, _killInfo];
            acex_killTracker_outputText = (TT_eventsArray joinString "<br/>");
            ACE_player setVariable ["potato_miscFixes_eventsString", acex_killTracker_outputText, true];
        }] call CBA_fnc_addEventHandler;

        ["TT_death", {
            params ["_name", "_killInfo"];
            TT_eventsArray pushBack format ["Died: %1 %2", _name, _killInfo];
            acex_killTracker_outputText = (TT_eventsArray joinString "<br/>");
            ACE_player setVariable ["potato_miscFixes_eventsString", acex_killTracker_outputText, true];
        }] call CBA_fnc_addEventHandler;

        ADD_REPAIR_ACTION("Repair Left Track",'hitltrack',250);
        ADD_REPAIR_ACTION("Repair Right Track",'hitrtrack',249);
        ADD_REPAIR_ACTION("Repair Engine",'hitengine',248);
        ADD_REPAIR_ACTION("Repair Turret",'hitturret',247);
        ADD_REPAIR_ACTION("Repair Gun",'hitgun',246);

        [{CBA_missionTime > 0}, {addMissionEventHandler ["EachFrame", {call TT_fnc_checkBoundaries}]}] call CBA_fnc_waitUntilAndExecute;

        [] call TT_fnc_setSpectate;
    };
}] call CBA_fnc_waitUntilAndExecute;
