function data_cost = comp_data_cost(img_left, img_right, num_disp_vals, tau)
% data_cost: a 3D array of size height x width x num_disp_value; each
%   element data_cost(y,x,l) is the cost of assigning the label l to pixel 
%   p = (y,x)
% tau : scalar value
% num_disp_vals : number of dispary values. The disparity values range
%   between 0 and num_disp_vals-1

img_left = double(img_left);
img_right = double(img_right);

[h, w] = size(img_left);
tau_mat = tau*ones(h, w, 'double');
data_cost = zeros(h, w, num_disp_vals);
for lp=1:num_disp_vals
    img_right_s = circshift(img_right, [0, lp-1]); % check that sign is good
    term1 = abs(img_left - img_right_s);
    data_cost(:, :, lp) = min(term1, tau_mat);
end
end