function [M,maxr,maxc]=lcsg_q(a,b,Threshold)
%     figure;
    global arcs;
    global nodes;
    global track;
    global nodesR;
    global routegraph;
% for i=1:size(arcs,1)
%     arc(1,:) = nodes(arcs(i,1)+1, 1:2);
%     arc(2,:) = nodes(arcs(i,2)+1, 1:2);
%     plot(arc(:,1), arc(:,2),'color',[0.5,0.5,0.5],'LineWidth', 2);
%     hold on;
% end
    r=length(a);
    c=length(b);
    M1=initialize(a,b,Threshold);
    M=repmat(struct('value',0,'lr',0,'lc',0,'first',0,'Longitude',0,'Latitude',0,'color',[1,1,1]),r,c);%add point
    last=zeros(r,2);
    maxvalue=0;
    maxc=0;
    maxr=0;
   S=find(M1(:,1)>0);
    for i=1:length(S)
        M(S(i),1).value=M1(S(i),1);
        M(S(i),1).first=1;
        last(S(i),1)=1;
        last(S(i),2)=M1(S(i),1);
        % add point
      point.Longitude=track(1,1);
      point.Latitude=track(1,2);
      startp.Longitude=nodes(arcs(S(i),1)+1, 1);
      startp.Latitude=nodes(arcs(S(i),1)+1, 2);
      endp.Longitude=nodes(arcs(S(i),2)+1, 1);
      endp.Latitude=nodes(arcs(S(i),2)+1, 2);
      [M(S(i),1).Longitude,M(S(i),1).Latitude]=getFootPoint(point, startp, endp);
      M(S(i),1).color=rand(1,3);
    end
    [maxvalue,maxr]=max(M1(:,1));
    maxc=1;
    times=[];%统计平均时间
    for j=2:c
        tic;
        S=find(last(:,1)>0);
        newclear=zeros(r,1);
%% generate roadgraph  
       mid_node=[(b(j-1).x+b(j).x)/2,(b(j-1).y+b(j).y)/2];
       midnode_dis=norm([b(j-1).x,b(j-1).y]-[b(j).x,b(j).y])/2;
%% in space
       midnode_to_line=point2line(a,mid_node);
       [Array_in_dis]=find(midnode_to_line(:,1)<(midnode_dis+Threshold)); 
       L=Array_in_dis(find(M1(Array_in_dis,j)>0));
%% on network
       %nearnode=nodesR(knnsearch(nodesR,mid_node),:);  
%% begin generate M
        for i=1:length(S)
           %L=findnextline(S(i));
         
           %L=findpath(routegraph,S(i),midnode_dis+Threshold,Array_in_dis);
            for l=1:length(L)
                 if findpath(routegraph,S(i),L(l))<Threshold%M1(L(l),j)>0
                     newclear(L(l),1)=1;
                       if M(L(l),j).value<(M1(L(l),j)+M(S(i),last(S(i),1)).value)
                           M(L(l),j).value=M1(L(l),j)+M(S(i),last(S(i),1)).value;
                           M(L(l),j).lr=S(i);
                           M(L(l),j).lc=last(S(i),1);
                       end
                  end
            end
        end
%         axis([track(j,1)-0.005,track(j,1)+0.005, ...
%         track(j,2)-0.005, track(j,2)+0.005]);    
%         hold on;
%         plot(track(j,1),track(j,2),'b.');
%         hold on;
        %clear last
        S=find(newclear(:,1)>0);
        for i=1:length(S)
            last(S(i),1)=0;
            last(S(i),2)=0;
        end
        S=find([M(:,j).value]>0);
        for i=1:length(S)
             last(S(i),1)=j;
             last(S(i),2)=M(S(i),j).value;
             point.Longitude=track(j,1);
             point.Latitude=track(j,2);
             startp.Longitude=nodes(arcs(S(i),1)+1, 1);
             startp.Latitude=nodes(arcs(S(i),1)+1, 2);
             endp.Longitude=nodes(arcs(S(i),2)+1, 1);
             endp.Latitude=nodes(arcs(S(i),2)+1, 2);
             [M(S(i),j).Longitude,M(S(i),j).Latitude]=getFootPoint(point, startp, endp);
             rr=M(S(i),j).lr;
             cc=M(S(i),j).lc;
             M(S(i),j).color=M(rr,cc).color;
%              plot([M(rr,cc).Longitude,M(S(i),j).Longitude],[M(rr,cc).Latitude,M(S(i),j).Latitude],'.-','color',M(rr,cc).color);
%              hold on;
        end
        S=find((M1(:,j)'>0)&([M(:,j).value]==0));
        for i=1:length(S)
             M(S(i),j).value=M1(S(i),j);
             M(S(i),j).first=1;
             last(S(i),1)=j;
             last(S(i),2)=M(S(i),j).value;
             point.Longitude=track(j,1);
             point.Latitude=track(j,2);
             startp.Longitude=nodes(arcs(S(i),1)+1, 1);
             startp.Latitude=nodes(arcs(S(i),1)+1, 2);
             endp.Longitude=nodes(arcs(S(i),2)+1, 1);
             endp.Latitude=nodes(arcs(S(i),2)+1, 2);
             [M(S(i),j).Longitude,M(S(i),j).Latitude]=getFootPoint(point, startp, endp);
             M(S(i),j).color=rand(1,3);
        end    
        if maxvalue<max([M(:,j).value])
            [maxvalue,maxr]=max([M(:,j).value]);
            maxc=j;       
        end
        times=[times;toc];
%         [~,maxonline]=max([M(:,j).value]);
%         rr=M(maxonline,j).lr;
%         cc=M(maxonline,j).lc;
%         plot([M(rr,cc).Longitude,M(maxonline,j).Longitude],[M(rr,cc).Latitude,M(maxonline,j).Latitude],'r.-','lineWidth',2);
%         hold on;
%         pause(2);
        
    end
    disp(max(times)); 
    disp(mean(times)); 
    disp(min(times)); 
%     figure;
%     cdfplot(times);
%     title('');
%     xlabel('Matching Time(seconds)');
%     ylabel('Probability') ;
%     hold off;
        
end