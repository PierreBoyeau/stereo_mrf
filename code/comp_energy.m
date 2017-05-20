function energy = comp_energy(data_cost, disparity, lambda)
% data_cost: a 3D array of size height x width x num_disp_value; each
%   element data_cost(y,x,l) is the cost of assigning the label l to pixel 
%   p = (y,x)
% disparity: a 2D array of size height x width the disparity value of each 
%   pixel; the disparity values range from 0 till num_disp_value - 1
% lambda : a scalar value
% energy : a scalar value
      
energy = 0;
% 1rst step : Find selected terms of data_cost
[h, w, ~] = size(data_cost); 
for x=1:w
    for y=1:h
        energy = energy + data_cost(y, x, disparity(y, x));
    end
end

% Computing other term
vertical = (disparity(1:h-1, :) ~= disparity(2:h, :));
horizontal = (disparity(:, 1:w-1) ~= disparity(:, 2:w));
energy = energy + lambda*(sum(vertical(:)) + sum(horizontal(:)));
end