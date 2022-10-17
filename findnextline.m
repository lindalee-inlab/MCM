function [L]=findnextline(lineid)
global arcs;
L=find(arcs(lineid,1)==arcs(:,1));
L=[L;find(arcs(lineid,1)==arcs(:,2))];
L=[L;find(arcs(lineid,2)==arcs(:,1))];
L=[L;find(arcs(lineid,2)==arcs(:,2))];
L=unique(L);
end