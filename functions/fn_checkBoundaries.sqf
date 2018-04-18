#include "common_defines.inc";

if !(alive player) exitWith {
    diag_log "Removing each frame";
    removeMissionEventHandler ["EachFrame", _thisEventHandler];
};

TT_LOCATION_ARRAY params ["_markerName", "_width", "_height", "_rotation"];
if ((getPos player) inArea [getMarkerPos _markerName, _width, _height, _rotation, true]) exitWith {
    if !(isNil "TT_LAST_TIME") then {
        TT_LAST_TIME = nil;
        TT_LAST_TIME_DISPLAYED = nil;
        hintSilent "";
    };
};

private _currentTime = CBA_missionTime;
if (isNil "TT_LAST_TIME") exitWith {
    hintSilent format ["Return to the battlefield or DIE\n%1 second(s) left", round TT_secondsLeft];
    TT_LAST_TIME = _currentTime;
    TT_LAST_TIME_DISPLAYED = _currentTime;
};

private _timeElaplsed = _currentTime - TT_LAST_TIME;
TT_secondsLeft = TT_secondsLeft - _timeElaplsed;

if (TT_secondsLeft <= 0) exitWith {
    removeMissionEventHandler ["EachFrame", _thisEventHandler];
    hintSilent "BOOM!";
    (vehicle player) setDamage 1;
};

if (_currentTime - TT_LAST_TIME_DISPLAYED >= 1) then {
    hintSilent format ["Return to the battlefield or DIE\n%1 second(s) left", round TT_secondsLeft];
    TT_LAST_TIME_DISPLAYED = _currentTime;
};

TT_LAST_TIME = _currentTime;
