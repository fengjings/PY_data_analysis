clear all;clc;
%% initialize variables
A = [1 2;3 4;5 6]
B = [11 12;13 14;15 16]
C = [1 1;2 2]
v = [1;2;3]

%% matrix operations
A * C  % matrix multiplication
A .* B % element-wise multiplication
% A .* C  or A * B gives error - wrong dimensions
A .^ 2 % element-wise square of each element in A
1./v   % element-wise reciprocal
log(v)  % functions like this operate element-wise on vecs or matrices 
exp(v)
abs(v)

-v  % -1*v

v + ones(length(v), 1)  
% v + 1  % same

A'  % matrix transpose

%% misc useful functions

% max  (or min)
a = [1 15 2 0.5]
val = max(a)
[val,ind] = max(a) % val -  maximum element of the vector a and index - index value where maximum occur
val = max(A) % if A is matrix, returns max from each column 返回每列最大值

% compare values in a matrix & find
a < 3 % checks which values in a are less than 3
find(a < 3) % gives location of elements less than 3
A = magic(3) % generates a magic matrix - not much used in ML algorithms 九宫格，横竖斜相加相同
[r,c] = find(A>=7)  % row, column indices for values matching comparison

% sum, prod
sum(a)
prod(a) % 乘法
floor(a) % 向下取整   or ceil(a) 四舍五入
max(rand(3),rand(3)) % 对每个3*3矩阵，按位取较大值
max(A,[],1) % -  maximum along columns(defaults to columns - max(A,[])) 按列取最大值 1表示维度1
max(A,[],2) % - maximum along rows 按行取最大值 2表示维度2 
A = magic(9)
sum(A,1) % 按列相加，结果为一行
sum(A,2) % 按行相加，结果为1列
sum(sum( A .* eye(9) )) % 乘单位矩阵，然后所有数相加
sum(sum( A .* flipud(eye(9)) )) % 得到另一侧对角线并求和


% Matrix inverse (pseudo-inverse)
pinv(A)        % inv(A'*A)*A'
format long
pinv(A) * A