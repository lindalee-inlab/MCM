function [Longitude,Latitude]=getFootPoint(point, startp, endp)
A = endp.Latitude - startp.Latitude; 
B = startp.Longitude - endp.Longitude; 
C = endp.Longitude * startp.Latitude - startp.Longitude * endp.Latitude; 
if (A * A + B * B) < 1e-13
    Longitude=startp.Longitude;
    Latitude=startp.Latitude;
elseif abs(A * point.Longitude + B * point.Latitude + C) < 1e-13
    Longitude=point.Longitude;
    Latitude=point.Latitude;
else
    Longitude = (B * B * point.Longitude - A * B * point.Latitude - A * C) / (A * A + B * B);
    Latitude = (-A * B * point.Longitude + A * A * point.Latitude - B * C) / (A * A + B * B);
end

end