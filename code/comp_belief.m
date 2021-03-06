function [ beliefs ] = comp_belief( data_cost, msg_up, msg_down, msg_left, msg_right )
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
% beliefs: a 3D array of size height x width x num_disp_value; each
%   element beliefs(y,x,l) is the belief of pixel p = (y,x) taking the
%   label l
[height, width, ~] = size(data_cost);
beliefs = data_cost;
beliefs(:, 1:width-1, :) = beliefs(:, 1:width-1, :) + msg_left(:, 2:width, :);
beliefs(:, 2:width, :) = beliefs(:, 2:width, :) + msg_right(:, 1:width-1, :);
beliefs(1:height-1, :, :) = beliefs(1:height-1, :, :) + msg_up(2:height, :, :);
beliefs(2:height,:,:) = beliefs(2:height,:,:) + msg_down(1:height-1,:,:);

end

