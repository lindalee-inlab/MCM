function [M,maxr,maxc]=lcsg(a,b,Threshold)
    r=length(a);
    c=length(b);
%     M1=zeros(r,c);  
%     parfor i=1:r
%         for j=1:c
%             M1(i,j)=weightfunc(a(i),b(j),Threshold);
%         end
%     end
    M1=initialize(a,b,Threshold);
    M=repmat(struct('value',0,'lr',0,'lc',0,'first',0),r,c);
    last=zeros(r,2);
    f=1;
    maxvalue=0;
    maxc=0;
    maxr=0;
    for j=1:c
        if max(M1(:,j))>0        
            f=j;
            for i=1:r
                if M1(i,j)>0
                    M(i,j).value=M1(i,j);
                    M(i,j).first=1;
                    last(i,1)=j;
                    last(i,2)=M1(i,j);
                end
            end
            [maxvalue,maxr]=max(M1(:,j));
            maxc=j;
            break;
        end
    end
    for j=f+1:c
        for l=1:r
            if last(l,1)>0
               for i=1:r
                   if findnear(l,i)==0
                   if M1(i,j)>0
                       if M(i,j).value<(M1(i,j)+M(l,last(l,1)).value)
                           M(i,j).value=M1(i,j)+M(l,last(l,1)).value;
                           M(i,j).lr=l;
                           M(i,j).lc=last(l,1);
                       end
                   end
                   end
               end
            end
        end
        for i=1:r
            if M(i,j).value>0
                last(i,1)=j;
                last(i,2)=M(i,j).value;
            else
                if M1(i,j)>0
                    M(i,j).value=M1(i,j);
                    M(i,j).first=1;
                    last(i,1)=j;
                    last(i,2)=M(i,j).value;
                else                   
                    M(i,j).value=max([M(:,j-1).value]);
%                     if M(i,j).value>last(i,2)
%                         last(i,1)=0;
%                         last(i,2)=0;
%                     end
                end
                               
            end
        end
        if maxvalue<max([M(:,j).value])
            [maxvalue,maxr]=max([M(:,j).value]);
            maxc=j;       
        end
    end
    
    

end