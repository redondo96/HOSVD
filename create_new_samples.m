function [row, col, maxvalues, losses, prob_mat] = create_new_samples(X,Y,Space, ...
    tensor_orig,tensor_recon,samples, ...
    new_budget,strategy)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n_samples = size(samples,1);
losses = zeros(1,n_samples);

switch strategy
    case 'bff'  
        
        % Degree of fit
        for i = 1:n_samples
            pos = [samples(i,1) samples(i,2)];
            losses(i) = abs(tensor_orig(pos)-tensor_recon(pos));
        end

    case 'gff'
        
        % Degree of fit
        for i = 1:n_samples
            pos = [samples(i,1) samples(i,2)];
            losses(i) = 1 - abs(tensor_orig(pos) - tensor_recon(pos));
        end

    otherwise
        error('Unexpected strategy. Use "bff" for Bad Fit First or "gff" for Good Fit First.')
end

% Criticality
sum_losses = sum(losses,"all");
criticality = zeros(1,n_samples);
for i = 1:n_samples
    criticality(i) = losses(i)/sum_losses;
end

% Sampling weight
weight_mat = zeros(size(Space));
% Check also `find` and `ismember`
for ii = 1:size(Space,1)
    for jj = 1:size(Space,2)
        % ii -> rows, jj -> columns
        % If it is not a pivot
        if sum(ismember(samples,[ii jj],'rows')) ~= 1
            weight = 0;
            for i = 1:n_samples
                if samples(i,1) == ii || samples(i,2) == jj
                    weight = weight + criticality(i);
                end
            end
        else
            weight = 0;
        end
        weight_mat(ii,jj) = weight;
    end
end

% Sampling probability
total_sum = sum(weight_mat,"all");
prob_mat = weight_mat ./ total_sum;

% plot_probabilities(X,Y,prob_mat);

[maxvalues,ind] = maxk(prob_mat(:),new_budget);
[row,col] = ind2sub(size(prob_mat),ind);

end

