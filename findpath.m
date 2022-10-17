function [d]=findpath(routegraph,lineid,newlineid)
global arcs;
startid=arcs(lineid,1)+1;
endid=arcs(lineid,2)+1;
[P1,d1] = shortestpath(routegraph,startid,arcs(newlineid,1)+1);
[P2,d2] = shortestpath(routegraph,startid,arcs(newlineid,2)+1);
[P3,d3] = shortestpath(routegraph,endid,arcs(newlineid,1)+1);
[P4,d4] = shortestpath(routegraph,endid,arcs(newlineid,2)+1);
d=min([d1,d2,d3,d4]);
% L=[];
% step=routegraph.Edges.Weight(findedge(routegraph,startid,endid))+dis;
% for i=1:size(Array_in_dis,1)
%    [P,d] = shortestpath(routegraph,startid,arcs(Array_in_dis(i),1)+1);
%    if d<=step       
%        L=[L;Array_in_dis(i)];
%    end 
%    [P,d] = shortestpath(routegraph,startid,arcs(Array_in_dis(i),2)+1);
%    if d<=step 
%        L=[L;Array_in_dis(i)];
%    end
%     [P,d] = shortestpath(routegraph,endid,arcs(Array_in_dis(i),1)+1);
%    if d<=step 
%        L=[L;Array_in_dis(i)];
%    end 
%    [P,d] = shortestpath(routegraph,endid,arcs(Array_in_dis(i),2)+1);
%    if d<=step 
%        L=[L;Array_in_dis(i)];
%    end 
% end
% L=unique(L);
end