function [Delta,Psi,P,I] = Viterbi(A,B,Pi,O)
% 函数功能：利用维特比算法找到观测序列O的最优路径
% 思路：
% 1，初始化
%    delta_1(i) = Pi_i * b_i(o1),   i = 1,2,...,N
%    psi_1(i) = o,  i = 1,2,...,N
% 2,递推，对于t = 2,3,...,T
%    delta_t(i) = max_1-from-1-to-N(delta_t-1(j) * a_ji) * b_i(ot),   i = 1,2,...,N
%    psi_t(i) = arg max_1-from-1-to-N(delta_t-1(j) * a_ji),   i = 1,2,...,N
% 3,终止
%    最优路径概率P* = max_1-from-1-to-N(delta_T(i))
%    最优路径终点i*_T = arg max_1-from-1-to-N(delta_T(i))
% 4,最优路径回溯，对于t = T-1,T-2,...,1
%    i*_t = psi_t+1(i*_t+1)
%    最优路径I* = (i*_1,i*_2,...,i*_T)
% 【提示：“思路”中的i,j和本程序中的i,j不存在对应关系，只是方便理解原理】
% 
% 输入：模型参数A,B,Pi，观测序列O
% 输出：Delta矩阵：在时刻t状态为i的所有单个路径中概率最大值构成的矩阵，
%         为N*K阶，即行数表示状态数，列数表示时刻。
%       Psi矩阵：在时刻t状态为i的所有单个路径中概率最大路径的第t-1个结点构成的矩阵，
%         为N*K阶，即行数表示状态数，列数表示时刻。且第一列为0。
%       P：观测序列O的最优路径概率。
%       I：观测序列O的最优路径。
%         


A_size = size(A);
O_size = size(O);
N = A_size(1,1);%状态集个数
M = A_size(1,2);
K = O_size(1,1);

% 计算Delta矩阵第一列值
Delta = zeros(N,K);
for i = 1:M
    %Delta(i,1) = Pi(i) * B(i,O(1,1));
    Delta(i,1) =B(i,O(1,1));
end

% 递推计算Delta矩阵剩下值
Delta_j = zeros(M,1);
Psi = zeros(N,K);
Psi(:,1) = 0;
for t = 2:K
    for j = 1:N
        for i = 1:M
            Delta_j(i,1) = Delta(i,t-1) * A(i,j) * B(j,O(t,1));
        end
        [max_delta_j,psi] = max(Delta_j); %找到概率最大值
        Psi(j,t) = psi; %放置Psi矩阵
        Delta(j,t) = max_delta_j; %放置Delta矩阵
    end
end

[P_better,psi_k] = max(Delta(:,K));
P = P_better; % 最优路径概率
I = zeros(K,1);
I(K,1) = psi_k;
for t = K-1:-1:1
    I(t,1) = Psi(I(t+1,1),t+1); %路径回溯得到最优路径
end
