%author: Lichunyu
%date: 2020/5/13
close all;
clear all;
clc;

%Load data and reshape
subjects = 40;
samples = 10;
n = subjects * samples;
% pixels = prod([112 92]); % Image dimension: 112 x 92
pixels = prod([64 64]); % Image dimension: 112 x 92

% A = zeros(n, pixels);
load('./data.mat');% load A
S_tmp = zeros(subjects,pixels); 

% using random projection algorithm
t_range = 5:5:300;
num_t = size(t_range,2);
mis_class3 = zeros(num_t,1);
norm_F2 = zeros(num_t,1);
Time2= zeros(num_t,1);
norm_fea = norm(fea,'fro');
Pretime3 = zeros(num_t,1);%%%%%%%%%%%%%%%%%%%

 %H'
    H = hadamard(pixels)./sqrt(pixels);
    H = H';
    
 c = 2;  
 q = min(1, c*(log2(n)^2 / pixels));
 
for count  = 1:num_t
    tic;
    
    t = t_range(count);
    
    %using FJLT DH'P
    %XD
    D_R = rand(1,pixels)-0.5;
    for i = 1:pixels
       fea(:,i) = fea(:,i) * sign(D_R(i));
    end
    for i = 1:subjects
        S_tmp(i,:) = fea((i-1)*samples+1, :);
    end
    
    %P
    P = rand(pixels, t);
    for i = 1: pixels
        for j = 1:t
            if P(i,j) < q
                P(i,j) = normrnd(0, 1/sqrt(q));
            else
                P(i,j) = 0;
            end
        end
    end
    P_S = sparse(P);
    
start = tic;%%%%%%%%%%%%%%%%%%%%%%%%pre time
fea_RP = fea*H*P_S;
Pretime3(count) = toc(start);%%%%%%%%%%%%%%%%%%
S_tmp_RP = S_tmp*H*P_S;

S = zeros(subjects, t, 30);
for i = 1:30
    S(:,:,i) = S_tmp_RP;
end    

%kmeans
% Idx N*1的向量，存储的是每个点的聚类标号
% C K*P的矩阵，存储的是K个聚类质心位置
% sumD 1*K的和向量，存储的是类间所有点与该类质心点距离之和
% D N*K的矩阵，存储的是每个点与所有质心的距离
[Idx,C,sumD,D]=kmeans(fea_RP, subjects, 'Display', 'final', 'Distance', 'sqEuclidean', 'Replicates', 30, 'Start', S);
Time2(count) = toc;

%mis-classification
correct = 0;
for i = 1:n
    if Idx(i) == fix(i/samples) + 1
        correct = correct +1;
    end
end
mis_class3(count) = correct / (n);

%F here should go back to original fea
X = zeros(n,n);
Tab = tabulate(Idx);
Freq = Tab(:,2);
for i  = 1:n
    X(i,Idx(i)) = 1/sqrt(Freq(Idx(i)));
end
F = fea - X*X'*fea;
norm_F2(count) = (norm(F,'fro'))^2/(norm_fea^2);

end
grid on
plot(t_range,mis_class3,'.-')
hold on
% plot(t_range,norm_F2,'.-')
% hold on
% plot(t_range,Time2,'.-')
% hold on



