function [row, col, losses, prob_mat] = create_new_samples(X,Y,Space, ...
    tensor_orig,tensor_recon,samples, ...
    new_budget,strategy,rs_alpha)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

switch strategy
    case {'bff', 'gff'}
        
        [row, col, losses, prob_mat] = call_strategy_bff_gff(X,Y,Space, ...
            tensor_orig,tensor_recon,samples, ...
            new_budget,strategy,rs_alpha);

    case 'hybrid'
        
        b1 = floor(new_budget/2);
        b2 = new_budget-b1;

        [row1, col1, ~, ~] = call_strategy_bff_gff(X,Y,Space, ...
            tensor_orig,tensor_recon,samples, ...
            b1,'bff',0);

        [row2, col2, ~, ~] = call_strategy_bff_gff(X,Y,Space, ...
            tensor_orig,tensor_recon,samples, ...
            b2,'gff',0);

        row = cat(2,row1,row2);
        col = cat(2,col1,col2);

    otherwise
        error('Unexpected strategy. Use "bff" for Bad Fit First,"gff" for Good Fit First or "hybrid" for Hybrid strategy.')
end

end

