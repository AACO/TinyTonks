class Params {
    class City {
        title = "Select city to fight over";
        values[] = {-1,0,1,3};
        texts[] = {"Random","Kavala","Athira","Sofia"};
        default = -1;
    };
    class MarkerUpdateTime {
        title = "Time between marker updates";
        values[] = {-1,15,30,45,60,90,120};
        texts[] = {"Never Update","15s","30s","45s","60s","90s","120s"};
        default = 45;
    };
    class BWMF_ParamWeather {
        title = "Weather";
        function = "potato_missionModules_fnc_setWeather";
        values[] = {-1,0,1,2,3,4,5,6,7,8};
        texts[] = {"Leave it the fuck alone", "Clear (Calm)", "Cloudy (Light Winds)", "Cloudy (Strong Winds)", "Overcast (Calm)", "Overcast (Light Winds)", "Overcast (Strong Winds)", "Rain (Light Winds)", "Rain (Strong Winds)", "Storm"};
        default = -1;
    };
    class BWMF_ParamFog {
        title = "Fog";
        function = "potato_missionModules_fnc_setFog";
        values[] = {-1,0,0.2,0.4,0.6};
        texts[] = {"Leave it the fuck alone", "None","Light","Medium","Heavy"};
        default = -1;
    };
    class BWMF_ParamTimeOfDay {
        title = "Time of Day";
        function = "potato_missionModules_fnc_setTime";
        values[] = {-1,0,1,2,3,4,5,6,7};
        texts[] = {"Leave it the fuck alone", "Dawn", "Early Morning", "Morning", "Noon", "Afternoon", "Evening", "Dusk", "Night"};
        default = -1;
    };
};
