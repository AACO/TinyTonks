#include "common_defines.inc"

params ["_tonks"];
{
    if (alive _x) then {
        (_x getVariable MARKER_VAR) setMarkerPos (getPos _x);
    } else {
        (_x getVariable MARKER_VAR) setMarkerType "KIA";
        _tonks set [_forEachIndex, nil];
    };
} forEach _tonks;

[TT_fnc_updateMarkers, [_tonks arrayIntersect _tonks], TT_MARKER_UPDATE_TIME] call CBA_fnc_waitAndExecute;
