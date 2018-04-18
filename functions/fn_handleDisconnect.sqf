params ["_unit"];

private _tonk = vehicle _unit;
if (alive _unit) then { _unit setDamage 1; };

if (_tonk != _unit && alive _tonk) then { _tonk setDamage 1; };

false
