function ECEF = GEO2ECEF(Lat,Long,h)
%%% Converts Lattitude (deg) Longitude (deg) and Altitude [m] to ECEF [m] using WGS84 Model
%%% [X Y Z] = ECEF2GEO(30,30,100)

a       = 6378137; % m
b       = 6356752.3142; %m
e       = sqrt(1 - (b^2/a^2));

N       = a/(sqrt(1-e^2*sind(Lat)^2));

X       = (N+h)*cosd(Lat)*cosd(Long);
Y       = (N+h)*cosd(Lat)*sind(Long);
Z       = (N*(1-e^2)+h)*sind(Lat);

ECEF    = [X,Y,Z];
end