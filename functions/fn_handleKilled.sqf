#include "common_defines.inc"

params ["_killed", "_killer", "_instigator"];

if (_killed isKindOf TINY_TONK_TYPE) then {
    private _player = _killed getVariable [PLAYER_VAR, objNull];
    if (!(isNull _player)) then {
        _killer = if (isNull _instigator) then {
            effectiveCommander _killer
        } else {
            _instigator
        };

        // If unit was player then send event to self
        private _killerName = "Self?";
        if ((!isNull _killer) && {_player != _killer}) then {
            _killerName = [_killer, true, false] call ace_common_fnc_getName;
        };
        ["TT_death", [_killerName, ""]] call CBA_fnc_localEvent;

        // If killer was player then send event to killer
        private _unitName = [_player, true, false] call ace_common_fnc_getName;
        ["TT_kill", [_unitName, ""], _killer] call CBA_fnc_targetEvent;

        _player setDamage 1;
    };
    (_killed getVariable DRIVER_VAR) setDamage 1;

    private _tonksLeft =  (entities TINY_TONK_TYPE) select {alive _x};
    private _numberOfTonksLeft = count _tonksLeft;
    diag_log format ["%1, %2, %3", _tonksLeft, _numberOfTonksLeft, entities TINY_TONK_TYPE];
    if (_numberOfTonksLeft <= 1) then {
        private _winningPlayer = if (_numberOfTonksLeft == 1) then {
            private _player = effectiveCommander (_tonksLeft#0);
            [format ["Only %1 survives", name _player]] remoteExecCall ["hintSilent"];
            _player
        } else {
            ["No survivors"] remoteExecCall ["hintSilent"];
            objNull
        };
        [{_this remoteExecCall ["TT_fnc_endMission"]}, [_winningPlayer], 5] call CBA_fnc_waitAndExecute;
    };

};

if (isPlayer _killed && alive (_player getVariable [TONK_VAR, objNull])) then {
    (_player getVariable [TONK_VAR, objNull]) setDamage 1;
};
