params ["_unit"];

if (local _unit) then {
    [
        {
            params ["_unit", "_tonk"];
            _unit assignAsCommander _tonk;
            _unit moveInCommander _tonk;
            commander _tonk == _unit
        },
        {},
        _this
    ] call CBA_fnc_waitUntilAndExecute;
};

_unit allowDamage false;
