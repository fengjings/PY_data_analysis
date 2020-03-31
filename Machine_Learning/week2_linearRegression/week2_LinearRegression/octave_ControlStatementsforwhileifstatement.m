close all;clear all;clc;



v = zeros(10,1);
v
for i=1:10 
    v(i) = 2^i;
end
% Can also use "break" and "continue" inside for and while loops to control execution.
v
i = 1;
while i <= 5,
  v(i) = 100; 
  i = i+1;
end
v
i = 1;
while true, 
  v(i) = 999; 
  i = i+1;
  if i == 6,
    break;
  end;
end
v
if v(1)==1,
  disp('The value is one!');
elseif v(1)==2,
  disp('The value is two!');
else
  disp('The value is not one or two!');
end

squareThisNumber(10)
[a,b] = squareandCubeThisNo(9)
% 修改路径
% Navigate to directory:
% cd /path/to/function

% Call the function:
% functionName(args)

% 添加路径
% To add the path for the current session of Octave:
% addpath('/path/to/function/')

% To remember the path for future sessions of Octave, after executing addpath above, also do:
% savepath

function y = squareThisNumber(x)

y = x^2;
end

% return more than one value:
function [y1, y2] = squareandCubeThisNo(x)
y1 = x^2;
y2 = x^3;
end














% A = [1 2; 3 4; 5 6]
% B = [1 2 3; 4 5 6]
% A*B
% B'
% 
% 
% c = zeros(5)
% a=magic(5)
% c = a.^2