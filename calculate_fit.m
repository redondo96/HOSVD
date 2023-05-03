function fit = calculate_fit(tensor_orig,decomposition)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

tensor_recon = full(decomposition);
% In reality it is loss
fit = norm(tensor_recon-tensor_orig)/norm(tensor_orig);

end

