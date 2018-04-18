#include "common_defines.inc"

if !(isServer) exitWith {};

private _tonks = [];
private _markerPrefix = format ["%1_spawn_", TT_LOCATION_ARRAY#0];
private _markers = allMapMarkers select { (toLower _x) find _markerPrefix  > -1 };
private _players = allUnits;

while {!(_players isEqualTo [])} do {
    private _player = _players deleteAt (floor random (count _players));
    private _marker = _markers deleteAt (floor random (count _markers));

    private _tt = createVehicle [TINY_TONK_TYPE, getMarkerPos _marker, [], 0, "NONE"];
    _tt setDir markerDir _marker;
    _tt setVehicleLock "LOCKED";
    _tt allowCrewInImmobile true;
    _tt removeWeaponTurret ["LMG_coax_ext", [0]];
    _tt removeMagazinesTurret ["60Rnd_20mm_AP_shells", [0]];
    for "_i" from 0 to 4 do {
        _tt addMagazineTurret ["60Rnd_20mm_HE_shells", [0]];
    };

    private _number = ((vehicleVarName _player) splitString "_") select 1;
    private _tonkMarker = createMarker [format ["TT_marker_%1", _number], [-99999, -99999]];
    _tonkMarker setMarkerShape "ICON";
    _tonkMarker setMarkerType "o_armor";
    _tonkMarker setMarkerColor "ColorRed";
    _tonkMarker setMarkerSize [0.75, 0.75];
    _tonkMarker setMarkerText format ["TT %1", _number];
    _tonks pushBack _tt;

    private _ttDriver = (group _player) createUnit [DRIVER_TYPE, getMarkerPos _marker, [], 0, "NONE"];
    _ttDriver assignAsDriver _tt;
    _ttDriver moveInDriver _tt;

    [_player, _tt] remoteExecCall ["TT_fnc_setupRemote"];
    _tt setVariable [PLAYER_VAR, _player];
    _tt setVariable [DRIVER_VAR, _ttDriver];
    _tt setVariable [MARKER_VAR, _tonkMarker];
    _player setVariable [TONK_VAR, _tt];
};

TT_LOCATION_ARRAY call TT_fnc_coverMap;

addMissionEventHandler ["HandleDisconnect", {_this call TT_fnc_handleDisconnect}];
addMissionEventHandler ["EntityKilled", {_this call TT_fnc_handleKilled}];

if (TT_MARKER_UPDATE_TIME > -1) then {
    [
        {CBA_missionTime > 0},
        {[TT_fnc_updateMarkers, _this, TT_MARKER_UPDATE_TIME] call CBA_fnc_waitAndExecute},
        [_tonks]
    ] call CBA_fnc_waitUntilAndExecute;
};
