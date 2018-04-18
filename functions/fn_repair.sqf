#include "common_defines.inc"
#define MAIN_DISPLAY (findDisplay 46)
#define RUIID "tt_repair_progress"
#define RUI (uiNamespace getVariable RUIID)

params ["_unit", "", "", "_hitPoint"];

disableUserInput true;

uiNamespace setVariable [RUIID, MAIN_DISPLAY ctrlCreate ["RscProgress", -1]];
RUI setVariable ["params", [CBA_missionTime, CBA_missionTime + 2 + (random 3), _unit, vehicle _unit, _hitPoint]];
RUI ctrlSetPosition [0.4 * safezoneW + safezoneX, 0.4 * safezoneH + safezoneY, 0.2 * safezoneW, 0.1 * safezoneH];
RUI progressSetPosition 0;
RUI ctrlCommit 0;

addMissionEventHandler ["EachFrame", {
    (RUI getVariable "params") params ["_start", "_end", "_unit", "_vehicle", "_hitPoint"];

    if !(alive _unit && alive _vehicle) exitWith {
        disableUserInput false;
        ctrlDelete RUI;
        removeMissionEventHandler ["EachFrame", _thisEventHandler];
    };

    private _progress = linearConversion [_start, _end, time, 0, 1];
    RUI progressSetPosition _progress;

    if (_progress >= 1) then {
        disableUserInput false;
        ctrlDelete RUI;
        removeMissionEventHandler ["EachFrame", _thisEventHandler];
        _vehicle setHitPointDamage [_hitPoint, 0.4, false];
    };
}];
