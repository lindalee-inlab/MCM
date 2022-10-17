function [I]=HMM_MM(a,b,EMIS)
    N=length(a);
    M=length(b);
    
    Delta = zeros(N,M);
    Delta(:,1) =EMIS(:,1);
    % ���Ƽ���Delta����ʣ��ֵ
    Delta_j = zeros(N,1);
    Psi = zeros(N,M);
    Psi(:,1) = 0;
   for t = 2:M
      [Trans]=createTrans(a,b(t-1),b(t));
      for j = 1:N
        for i = 1:N
            Delta_j(i,1) = Delta(i,t-1) * Trans(i,j) * EMIS(j,t);
        end
        [max_delta_j,psi] = max(Delta_j); %�ҵ��������ֵ
        Psi(j,t) = psi; %����Psi����
        Delta(j,t) = max_delta_j; %����Delta����
      end
   end
[P_better,psi_k] = max(Delta(:,M));
I = zeros(M,1);
I(M,1) = psi_k;
for t = M-1:-1:1
    I(t,1) = Psi(I(t+1,1),t+1); %·�����ݵõ�����·��
end
    
    
end