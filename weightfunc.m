function [result]=weightfunc(a,b,Threshold)
%point to line's distance
    A=a.y1-a.y2;
    B=a.x2-a.x1;
    C=a.x1*a.y2-a.x2*a.y1;
    disPtL=abs(A*b.x+B*b.y+C)/sqrt(A*A+B*B);
    if disPtL<=Threshold(1)
        result=Threshold(1)-disPtL; 
    else 
        result=0;
    end
end