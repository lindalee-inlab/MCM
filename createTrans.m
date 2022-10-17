function [Trans]=createTrans(a,b1,b2)
    N=length(a);
    t=sqrt((b2.x-b1.x)*(b2.x-b1.x)+(b2.y-b1.y)*(b2.y-b1.y));
    L=[];
    for i=1:N
        L(i,1)=a(i).x1;
        L(i,2)=a(i).y1 ;
        L(i,3)=a(i).x2 ;
        L(i,4)=a(i).y2;
    end
    A=L(:,2)-L(:,4);
    B=L(:,3)-L(:,1);
    C=L(:,1).*L(:,4)-L(:,3).*L(:,2);
    P1(:,1)=(B.*B*b1.x-A.*B*b1.y-A.*C)./sqrt(A.*A+B.*B);
    P1(:,2)=(A.*A*b1.y-A.*B*b1.x-B.*C)./sqrt(A.*A+B.*B);
    P2(:,1)=(B.*B*b2.x-A.*B*b2.y-A.*C)./sqrt(A.*A+B.*B);
    P2(:,2)=(A.*A*b2.y-A.*B*b2.x-B.*C)./sqrt(A.*A+B.*B);
    D=abs(sqrt(P2(:,1)-P1(:,1))*(P2(:,1)-P1(:,1))'+(P2(:,2)-P1(:,2))*(P2(:,2)-P1(:,2))'-t);
    Trans=exppdf(D,3);
end