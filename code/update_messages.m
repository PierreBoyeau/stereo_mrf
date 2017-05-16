function [ msg_up, msg_down, msg_left, msg_right] = update_messages( msg_up_prev, msg_down_prev, msg_left_prev, msg_right_prev, data_cost, lambda)
% data_cost: a 3D array of size height x width x num_disp_value; each
%   element data_cost(y,x,l) is the cost of assigning the label l to pixel 
%   p = (y,x)
% msg_up : a 3D array of size height x width x num_disp_value; each vector
%   msg_up(y,x,1:num_disp_values) is the message vector that the pixel 
%   p = (y,x) will send to the pixel up with coordinates q = (y-1,x)
% msg_down : a 3D array of size height x width x num_disp_value; each vector
%   msg_down(y,x,1:num_disp_values) is the message vector that the pixel 
%   p = (y,x) will send to the pixel down with coordinates q = (y+1,x)
% msg_left : a 3D array of size height x width x num_disp_value; each vector
%   msg_left(y,x,1:num_disp_values) is the message vector that the pixel 
%   p = (y,x) will send to the pixel left with coordinates q = (y,x-1)
% msg_right : a 3D array of size height x width x num_disp_value; each vector
%   msg_right(y,x,1:num_disp_values) is the message vector that the pixel 
%   p = (y,x) will send to the pixel right with coordinates q = (y,x+1)
% lambda : scalar value 

% For convenience don't compute the messages that are send from pixels that are on the boundaries of the image. 
% Compute the messages only for the pixels with coordinates (y,x) = ( 2:(height-1) , 2:(width-1) )

[height, width, num_disp_value] = size(data_cost);
msg_left = zeros(height, width, num_disp_value);
msg_right = zeros(height, width, num_disp_value);
msg_up = zeros(height, width, num_disp_value);
msg_down = zeros(height, width, num_disp_value);

msg_other = zeros(height, width, num_disp_value);
msg_center = zeros(height, width, num_disp_value);

y_ind = 2:height-1;
x_ind = 2:width-1;
l_ind = 1:num_disp_value;

%%% Premier terme indépendant du reste

%%% Left 
x_left = 1:width-2;
msg_center(y_ind, x_ind, l_ind) = data_cost(y_ind, x_left, l_ind)...
    + msg_up_prev(y_ind, x_left, l_ind)...
    + msg_down_prev(y_ind, x_left, l_ind)...
    + msg_right_prev(y_ind, x_left, l_ind) ...
    + msg_left_prev(y_ind, x_left, l_ind);
msg_other(y_ind, x_ind, l_ind) = data_cost(y_ind, x_ind, l_ind) ...
    + msg_up_prev(y_ind, x_ind, l_ind)...
    + msg_down_prev(y_ind, x_ind, l_ind)...
    + msg_right_prev(y_ind, x_ind, l_ind)...
    + lambda;
msg_left(y_ind, x_ind, l_ind) = min(msg_center(y_ind, x_ind, l_ind), msg_other(y_ind, x_ind, l_ind));
%%% Right 
x_right = 3:width;
msg_center(y_ind, x_ind, l_ind) = data_cost(y_ind, x_right, l_ind)...
    + msg_up_prev(y_ind, x_right, l_ind)...
    + msg_down_prev(y_ind, x_right, l_ind)...
    + msg_right_prev(y_ind, x_right, l_ind) ...
    + msg_left_prev(y_ind, x_right, l_ind);
msg_other(y_ind, x_ind, l_ind) = data_cost(y_ind, x_ind, l_ind)...
    + msg_up_prev(y_ind, x_ind, l_ind)...
    + msg_down_prev(y_ind, x_ind, l_ind)...
    + msg_left_prev(y_ind, x_ind, l_ind)...
    + lambda;
msg_right(y_ind, x_ind, l_ind) = min(msg_center(y_ind, x_ind, l_ind), msg_other(y_ind, x_ind, l_ind));
%%% Up 
y_up = 1:height-2;
msg_center(y_ind, x_ind, l_ind) = data_cost(y_up, x_ind, l_ind)...
    + msg_up_prev(y_up, x_ind, l_ind)...
    + msg_down_prev(y_up, x_ind, l_ind)...
    + msg_right_prev(y_up, x_ind, l_ind) ...
    + msg_left_prev(y_up, x_ind, l_ind);
msg_other(y_ind, x_ind, l_ind) = data_cost(y_ind, x_ind, l_ind)...
    + msg_right_prev(y_ind, x_ind, l_ind)...
    + msg_down_prev(y_ind, x_ind, l_ind)...
    + msg_left_prev(y_ind, x_ind, l_ind)...
    + lambda; 
msg_up(y_ind, x_ind) = min(msg_center(y_ind, x_ind, l_ind), msg_other(y_ind, x_ind, l_ind));
%%% Down
y_down = 3:height;
msg_center(y_ind, x_ind, l_ind) = data_cost(y_down, x_ind, l_ind)...
    + msg_up_prev(y_down, x_ind, l_ind)...
    + msg_down_prev(y_down, x_ind, l_ind)...
    + msg_right_prev(y_down, x_ind, l_ind) ...
    + msg_left_prev(y_down, x_ind, l_ind);
msg_other(y_ind, x_ind, l_ind) = data_cost(y_ind, x_ind, l_ind)...
    + msg_up_prev(y_ind, x_ind, l_ind)...
    + msg_right_prev(y_ind, x_ind,l_ind)...
    +msg_left_prev(y_ind, x_ind, l_ind)...
    + lambda; 
msg_down(y_ind, x_ind) = min(msg_center(y_ind, x_ind, l_ind), msg_other(y_ind, x_ind, l_ind));
end

