function dis=distance(L1,L2,L3,L4)
c = sin(L2/57.2958)*sin(L4/57.2958) + cos(L2/57.2958)*cos(L4/57.2958)*cos(L1-L3)/57.2958;
dis = 6371.004*acos(c);
end