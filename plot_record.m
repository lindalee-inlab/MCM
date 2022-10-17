function plot_record(id,M,maxr,maxc)%
  % load the record
  fn = sprintf('./%08d/%08d', id, id);
  track = dlmread([fn,'.track'], '\t');
  route = dlmread([fn,'.route'], '\t');
  nodes = dlmread([fn,'.nodes'], '\t');
  arcs = dlmread([fn,'.arcs'], '\t');
  
  figure;
  hold on;
  xmargin = (-min(nodes(:,1))+max(nodes(:,1)))/20;
  ymargin = (-min(nodes(:,2))+max(nodes(:,2)))/20;
  axis([min(nodes(:,1))-xmargin, max(nodes(:,1))+xmargin, ...
        min(nodes(:,2))-ymargin, max(nodes(:,2))+ymargin]);

  % render the map
  for i=1:size(arcs,1)
    arc(1,:) = nodes(arcs(i,1)+1, 1:2);
    arc(2,:) = nodes(arcs(i,2)+1, 1:2);
    plot(arc(:,1), arc(:,2),'color',[0.5,0.5,0.5],'LineWidth', 2);
  end
  
  % render the track
  plot(track(:,1), track(:,2), '.','color',[1,0.5,0],'Markersize',8);

  % render the route
  for i=1:size(route,1)
    arc(1,:) = nodes(arcs(route(i)+1,1)+1, 1:2);
    arc(2,:) = nodes(arcs(route(i)+1,2)+1, 1:2);
    plot(arc(:,1), arc(:,2), 'r', 'LineWidth', 2);


  end
  
  r=maxr;
  c=maxc;
  arcs = dlmread([fn,'.arcs'], '\t');
  while M(r,c).first==0
      plot([nodes(arcs(r,1)+1, 1),nodes(arcs(r,2)+1, 1)],[nodes(arcs(r,1)+1, 2),nodes(arcs(r,2)+1, 2)], 'b', 'LineWidth', 1);
%       point.Longitude=track(c,1);
%       point.Latitude=track(c,2);
%       startp.Longitude=nodes(arcs(r,1)+1, 1);
%       startp.Latitude=nodes(arcs(r,1)+1, 2);
%       endp.Longitude=nodes(arcs(r,2)+1, 1);
%       endp.Latitude=nodes(arcs(r,2)+1, 2);
%       [Longitude,Latitude]=getFootPoint(point, startp, endp);
%       plot(Longitude, Latitude, 'b.','Markersize',8);
      nr=M(r,c).lr;
      nc=M(r,c).lc;
      r=nr;
      c=nc;
  end
  
end
