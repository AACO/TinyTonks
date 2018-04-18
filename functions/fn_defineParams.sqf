#include "common_defines.inc";

if !(isServer) exitWith {};

TT_LOCATIONS_ARRAY = [
    ["kavala", 400, 700, 20], // marker, width, height, rotation
    ["athira", 500, 900, 330],
    ["sofia", 600, 700, 55]
];

paramsArray params [
    "_location",
    "_markerUpdateTime"
];

TT_LOCATION_ARRAY = if (_location < 0) then {
    selectRandom TT_LOCATIONS_ARRAY
} else {
    TT_LOCATIONS_ARRAY select (_location min (count TT_LOCATIONS_ARRAY))
};
publicVariable "TT_LOCATION_ARRAY";

TT_MARKER_UPDATE_TIME = _markerUpdateTime;
