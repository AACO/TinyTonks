if (!isNil "acre_api_fnc_setSpectator") then {
    [true] call acre_api_fnc_setSpectator;
};

if !(isNil "TFAR_fnc_forceSpectator") then {
    [player, true] call TFAR_fnc_forceSpectator
};
