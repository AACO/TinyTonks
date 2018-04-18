params ["_winningPlayer"];

if ((!hasInterface) || {player == _winningPlayer}) then {
    ["", true, 1] call BIS_fnc_endMission;
} else {
    ["", false, 1] call BIS_fnc_endMission;
};
