clear,clc;
A = [1,2; 3,4; 5,6]
size(A);
sz = size(A)
size(sz)
size(A,1)
size(A,2)
v = [1,2,3,4]
length(v)
% % % % current path
pwd 
% % % % change dir
% cd 'C:\'
% % % % show files
% ls
q1y = load('priceY.txt');   % alternatively, load('q1y.dat')
q1x = load('featuresX.txt');
who   % list variables in workspace
whos  % list variables in workspace (detailed view) 
clear q1y      % clear command without any args clears all vars
v = q1x(1:10); % first 10 elements of q1x (counts down the columns)
save hello.mat v;  % save variable v into file hello.mat
% 使用方法
% clear
% load('hello.mat')
% who
% whos
save hello.txt v -ascii; % save as ascii
% fopen, fread, fprintf, fscanf also work  [[not needed in class]]

%% indexing
A(3,2)  % indexing is (row,col)
A(2,:)  % get the 2nd row. 
        % ":" means every element along that dimension
A(:,2)  % get the 2nd col
A([1 3],:) % print all  the elements of rows 1 and 3

A(:,2) = [10; 11; 12]     % change second column
A = [A, [100; 101; 102]]; % append column vec
A(:) % Select all elements as a column vector.

% Putting data together 
A = [1 2; 3 4; 5 6]
B = [11 12; 13 14; 15 16] % same dims as A
C = [A B]  % concatenating A and B matrices side by side
C = [A, B] % concatenating A and B matrices side by side
C = [A; B] % Concatenating A and B top and bottom





