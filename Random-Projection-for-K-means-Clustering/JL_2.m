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
pixels = prod([64 64]);

% A = zeros(subjects*samples, pixels);
% S_tmp = zeros(subjects,pixels); 
% for i = 1:subjects
%     for j = 1:samples
%         imageName=strcat('.\orl_faces\s', int2str(i), '\', int2str(j), '.pgm');
%         tmp = imread(imageName);
%         tmp = reshape(tmp.', 1, pixels);
%         A((i-1)*samples+j, :) = tmp;
%         if j == 1
%             S_tmp(i, :) = tmp;
%         end
%     end
% end
load('./data.mat');% load A
A = fea;
S_tmp = zeros(subjects,pixels); 
for i = 1:subjects
    S_tmp(i,:) = A((i-1)*samples+1, :);
end

% using random projection algorithm
t_range = 5:5:300;
num_t = size(t_range,2);
mis_class2 = zeros(num_t,1);
norm_F2 = zeros(num_t,1);
Time2= zeros(num_t,1);
norm_A = norm(A,'fro');
Pretime2 = zeros(num_t,1);%%%%%%%%%%%%%%%%%%%

for count  = 1:num_t
    tic;
    
    t = t_range(count);
    R = randn(pixels, t);
    R = R./sqrt(t);
start = tic;%%%%%%%%%%%%%%%%%%%%%%%%pre time
A_RP = A*R;
Pretime2(count) = toc(start);%%%%%%%%%%%%%%%%%%
S_tmp_RP = S_tmp*R;

S = zeros(subjects, t, 30);
for i = 1:30
    S(:,:,i) = S_tmp_RP;
end    

%kmeans
% Idx N*1的向量，存储的是每个点的聚类标号
% C K*P的矩阵，存储的是K个聚类质心位置
% sumD 1*K的和向量，存储的是类间所有点与该类质心点距离之和
% D N*K的矩阵，存储的是每个点与所有质心的距离
[Idx,C,sumD,D]=kmeans(A_RP, subjects, 'Display', 'final', 'Distance', 'sqEuclidean', 'Replicates', 30, 'Start', S);
Time2(count) = toc;

%mis-classification
correct = 0;
for i = 1:subjects*samples
    if Idx(i) == fix(i/samples) + 1
        correct = correct +1;
    end
end
mis_class2(count) = correct / (samples*subjects);

%F here should go back to original A
X = zeros(samples*subjects,samples*subjects);
Tab = tabulate(Idx);
Freq = Tab(:,2);
for i  = 1:subjects*samples
    X(i,Idx(i)) = 1/sqrt(Freq(Idx(i)));
end
F = A - X*X'*A;
norm_F2(count) = (norm(F,'fro'))^2/(norm_A^2);

end



