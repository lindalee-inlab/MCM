function [Delta,Psi,P,I] = Viterbi(A,B,Pi,O)
% �������ܣ�����ά�ر��㷨�ҵ��۲�����O������·��
% ˼·��
% 1����ʼ��
%    delta_1(i) = Pi_i * b_i(o1),   i = 1,2,...,N
%    psi_1(i) = o,  i = 1,2,...,N
% 2,���ƣ�����t = 2,3,...,T
%    delta_t(i) = max_1-from-1-to-N(delta_t-1(j) * a_ji) * b_i(ot),   i = 1,2,...,N
%    psi_t(i) = arg max_1-from-1-to-N(delta_t-1(j) * a_ji),   i = 1,2,...,N
% 3,��ֹ
%    ����·������P* = max_1-from-1-to-N(delta_T(i))
%    ����·���յ�i*_T = arg max_1-from-1-to-N(delta_T(i))
% 4,����·�����ݣ�����t = T-1,T-2,...,1
%    i*_t = psi_t+1(i*_t+1)
%    ����·��I* = (i*_1,i*_2,...,i*_T)
% ����ʾ����˼·���е�i,j�ͱ������е�i,j�����ڶ�Ӧ��ϵ��ֻ�Ƿ������ԭ��
% 
% ���룺ģ�Ͳ���A,B,Pi���۲�����O
% �����Delta������ʱ��t״̬Ϊi�����е���·���и������ֵ���ɵľ���
%         ΪN*K�ף���������ʾ״̬����������ʾʱ�̡�
%       Psi������ʱ��t״̬Ϊi�����е���·���и������·���ĵ�t-1����㹹�ɵľ���
%         ΪN*K�ף���������ʾ״̬����������ʾʱ�̡��ҵ�һ��Ϊ0��
%       P���۲�����O������·�����ʡ�
%       I���۲�����O������·����
%         


A_size = size(A);
O_size = size(O);
N = A_size(1,1);%״̬������
M = A_size(1,2);
K = O_size(1,1);

% ����Delta�����һ��ֵ
Delta = zeros(N,K);
for i = 1:M
    %Delta(i,1) = Pi(i) * B(i,O(1,1));
    Delta(i,1) =B(i,O(1,1));
end

% ���Ƽ���Delta����ʣ��ֵ
Delta_j = zeros(M,1);
Psi = zeros(N,K);
Psi(:,1) = 0;
for t = 2:K
    for j = 1:N
        for i = 1:M
            Delta_j(i,1) = Delta(i,t-1) * A(i,j) * B(j,O(t,1));
        end
        [max_delta_j,psi] = max(Delta_j); %�ҵ��������ֵ
        Psi(j,t) = psi; %����Psi����
        Delta(j,t) = max_delta_j; %����Delta����
    end
end

[P_better,psi_k] = max(Delta(:,K));
P = P_better; % ����·������
I = zeros(K,1);
I(K,1) = psi_k;
for t = K-1:-1:1
    I(t,1) = Psi(I(t+1,1),t+1); %·�����ݵõ�����·��
end
