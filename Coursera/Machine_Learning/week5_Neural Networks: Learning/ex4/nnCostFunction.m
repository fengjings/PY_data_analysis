function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
a1 = [ones(length(X),1) X];% 5000*401
z2 = a1 * Theta1';% (25*401)*(401*5000)
a2 = sigmoid(z2);% (5000*25)

a2 = [ones(length(a2),1) a2];% (5000*26)
z3 = a2* Theta2';% (5000*26)*(26*10)
a3 = sigmoid(z3); %5000*10 % h_theta equals a3

y_cir = zeros(m,num_labels);%5000* 10
for i = 1:m
    for j = 1:num_labels
        y_cir(i,j) = (j == y(i));
        %%%%%%%%%%%%%%%%%%
        J = J + 1/m * ( -y_cir(i,j) * log(a3(i,j)) - (1-y_cir(i,j)) * log(1-a3(i,j)) );
    end
end

J = J + lambda/2/m * (sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2)));% 不要参数矩阵的第一列
% 也可以这样写：Theta1(:,2:size(Theta1,2));，Theta2(:,2:size(Theta2,2));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% delta3 = zeros(size(a3));
% delta3 = a3 - y; % 5000*10
% z2_new = [ones(length(z2),1) z2];% (5000*26)
% 
% temp = Theta2'*delta3';% (26*10) * (10*5000)=(26,5000) 
% delta2 = temp .* sigmoidGradient(z2_new)'; % (26,5000) .*(26,5000) =(26*5000)
% 
% delta2_new = delta2(2:end,:);%(25,5000)
% 
% large_delta2 = delta3' * a2;% (10,5000)*(5000,26)
% large_delta1 = delta2_new * a1;% (25,5000)*(5000,401)
% 
% Theta2_grad = 1/m .*large_delta2;
% Theta1_grad = 1/m .*large_delta1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Back propagation
Theta2_grad = 0;
Theta1_grad = 0;
for t=1:m

    % Step 1
	a1_temp = a1(t,:); % X already have a bias Line 44 (1*401)
    a1_temp = a1_temp'; % (401*1)
	z2_temp = Theta1 * a1_temp; % (25*401)*(401*1)
	a2_temp = sigmoid(z2_temp); % (25*1)
    
    a2_temp = [1 ; a2_temp]; % adding a bias (26*1)
	z3_temp = Theta2 * a2_temp; % (10*26)*(26*1)
	a3_temp = sigmoid(z3_temp); % final activation layer a3 == h(theta) (10*1)
    
    % Step 2
	delta_3 = a3_temp - y_cir(t,:)'; % (10*1)
	
    z2_temp=[1; z2_temp]; % bias (26*1)
    % Step 3
    delta_2 = (Theta2' * delta_3) .* sigmoidGradient(z2_temp); % ((26*10)*(10*1))=(26*1)

    % Step 4
	delta_2 = delta_2(2:end); % skipping sigma2(0) (25*1)

	Theta2_grad = Theta2_grad + delta_3 * a2_temp'; % (10*1)*(1*26)
	Theta1_grad = Theta1_grad + delta_2 * a1_temp'; % (25*1)*(1*401)
    
end

% Step 5
Theta2_grad = (1/m) .* Theta2_grad; % (10*26)
Theta1_grad = (1/m) .* Theta1_grad; % (25*401)

Theta1_grad(:, 2:end) = Theta1_grad(:, 2:end) + ((lambda/m) .* Theta1(:, 2:end)); % for j >= 1 
% 
% Theta2_grad(:, 1) = Theta2_grad(:, 1) ./ m; % for j = 0
% 
Theta2_grad(:, 2:end) = Theta2_grad(:, 2:end) + ((lambda/m) .* Theta2(:, 2:end)); % for j >= 1


% [M,I]= max(a3, [], 2);%10,5000 求index









% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
