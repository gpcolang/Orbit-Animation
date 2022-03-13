function lla = ECE2GEO(x,y,z)
%%% Converts ECEF to Lattitude Longitude and Altitude using WGS84 Model
%%% [lat long h] = ECEF2GEO(1000,1000,1000)

a       = 6378137; % m
b       = 6356752.3142; %m
e       = sqrt(1 - (b^2/a^2));

p       = sqrt(x^2+y^2);

zeta    = atan((z*a)/(p*b)); % rad

e_bar2  = (a^2-b^2)/(b^2);

lat     = atand((z+e_bar2*b*sin(zeta)^3)/(p-(e^2)*a*cos(zeta)^3));

long    = atan2d(y,x);

N       = a/sqrt(1-(e^2)*sind(lat)^2);

h       = p/cosd(lat) - N;

lla     = [lat, long, h];

end