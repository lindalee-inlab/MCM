function [EMIS]=createEMIS(a,b)
    N=length(a);
    M=length(b);
    L=[];
    for i=1:N
        L(i,1)=a(i).x1;
        L(i,2)=a(i).y1 ;
        L(i,3)=a(i).x2 ;
        L(i,4)=a(i).y2;
    end
    P=[];
    for i=1:M
        P(i,1)=b(i).x;
        P(i,2)=b(i).y ;
    end
    A=L(:,2)-L(:,4);
    B=L(:,3)-L(:,1);
    C=L(:,1).*L(:,4)-L(:,3).*L(:,2);
    D=abs(A*P(:,1)'+B*P(:,2)'+repmat(C,1,M))./(repmat(sqrt(A.*A+B.*B),1,M));
    EMIS=normpdf(D,0,4);%π€≤‚∏≈¬ æÿ’Û
end