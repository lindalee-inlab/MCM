function [D]=point2line(a,P)
    r=length(a);
    L=[];
    for i=1:r
        L(i,1)=a(i).x1;
        L(i,2)=a(i).y1 ;
        L(i,3)=a(i).x2 ;
        L(i,4)=a(i).y2;
    end
    A=L(:,2)-L(:,4);
    B=L(:,3)-L(:,1);
    C=L(:,1).*L(:,4)-L(:,3).*L(:,2);
    D=abs(A*P(:,1)'+B*P(:,2)'+repmat(C,1,1))./(repmat(sqrt(A.*A+B.*B),1,1));
end