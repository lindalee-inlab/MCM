clear;
global arcs;
global nodes;
global track;
global nodesR;
global routegraph;
id=48;
Threshold=10;
fn = sprintf('./%08d/%08d', id, id);
track = dlmread([fn,'.track'], '\t');
route = dlmread([fn,'.route'], '\t');
nodes = dlmread([fn,'.nodes'], '\t');
arcs = dlmread([fn,'.arcs'], '\t');
routegraph=digraph((arcs(:,1)+1)',(arcs(:,2)+1)');
axesm utm
Z=utmzone(nodes(1, 1),nodes(1, 2));
setm(gca,'zone',Z);
h = getm(gca); 
[xx,yy]= mfwdtran(h,nodes(1, 1),nodes(1, 2));
for i=1:size(nodes,1)
     [nodesR(i,1),nodesR(i,2)]= mfwdtran(h,nodes(i,1),nodes(i,2));
    nodesR(i,1)=nodesR(i,1)-xx;
    nodesR(i,2)=nodesR(i,2)-yy;
end
%% route graph weight
x=nodesR(:,1)';
y=nodesR(:,2)';
[sn,tn] = findedge(routegraph);
dx = x(sn) - x(tn);
dy = y(sn) - y(tn);
D = hypot(dx,dy);
routegraph.Edges.Weight = D';

for i=1:size(track,1)
    [trackR(i,1),trackR(i,2)]= mfwdtran(h,track(i,1),track(i,2));
    trackR(i,1)=trackR(i,1)-xx;
    trackR(i,2)=trackR(i,2)-yy;
end
for i=1:size(arcs,1)
    a(i).x1 = nodesR(arcs(i,1)+1, 1);
    a(i).y1 = nodesR(arcs(i,1)+1, 2);
    a(i).x2 = nodesR(arcs(i,2)+1, 1);
    a(i).y2 = nodesR(arcs(i,2)+1, 2);
    a(i).id=i;
end

for i=1:30%size(trackR,1)
    b(i).x=trackR(i,1);
    b(i).y=trackR(i,2);
end
%[M,maxr,maxc]=lcsg(a,b,Threshold);

[M,maxr,maxc]=lcsg_q(a,b,Threshold);
%  [EMIS]=createEMIS(a,b);
%  [I]=HMM_MM(a,b,EMIS);


