#define SIZE_OUT 100000
#define DOT_MARKER_SIZE 0.75

params ["_marker", "_width", "_height", "_rotation"];

private _pos = getMarkerPos _marker;
_pos params ["_posX", "_posY"];

for "_i" from 0 to 270 step 90 do {
    private _size1 = [_width, _height] select (abs cos _i);
    private _size2 = [_width, _height] select (abs sin _i);
    private _markerSize = [_size2, SIZE_OUT] select (abs sin _i);
    private _markerDir = _rotation + _i;
    private _markerPos = [_posX + (sin _markerDir * SIZE_OUT), _posY + (cos _markerDir * SIZE_OUT)];

    private _newMarker = createMarker [format ["TT_AO_%1", _i], _markerPos];
    _newMarker setMarkerSize [_markerSize, SIZE_OUT - _size1];
    _newMarker setMarkerDir _markerDir;
    _newMarker setMarkerShape "rectangle";
    _newMarker setMarkerBrush "solid";
    _newMarker setMarkerColor "colorBlack";

    private _markerDotPos = [
        _posX + (sin _markerDir * _size1) + (sin (_markerDir + 90) * _size2),
        _posY + (cos _markerDir * _size1) + (cos (_markerDir + 90) * _size2)
    ];
    private _newDotMarker = createMarker [format ["TT_AO_DOT_%1", _i], _markerDotPos];
    _newDotMarker setMarkerSize [DOT_MARKER_SIZE, DOT_MARKER_SIZE];
    _newDotMarker setMarkerDir _rotation;
    _newDotMarker setMarkerType "mil_box_noShadow";
    _newDotMarker setMarkerColor "colorBlack";
};

private _newBorderMarker = createMarker ["TT_AO_BORDER", _pos];
_newBorderMarker setMarkerSize [_width, _height];
_newBorderMarker setMarkerDir _rotation;
_newBorderMarker setMarkerShape "rectangle";
_newBorderMarker setMarkerBrush "border";
_newBorderMarker setMarkerColor "colorblack";
