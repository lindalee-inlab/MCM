function [dis]=findnear(lastid,newid)
global arcs;
     dis=1;
     if lastid==newid
         dis=0;
     else
         if arcs(lastid,1)==arcs(newid,1)||arcs(lastid,1)==arcs(newid,2)||arcs(lastid,2)==arcs(newid,1)||arcs(lastid,2)==arcs(newid,2)
             dis=0;
         end            
     end
end