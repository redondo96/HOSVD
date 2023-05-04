function [row, col, losses, prob_mat] = call_strategy_bff_gff(X,Y,Space, ...
    tensor_orig,tensor_recon,samples, ...
    new_budget,strategy,rs_alpha)
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
        error('Unexpected strategy. Use "bff" for Bad Fit First,"gff" for Good Fit First or "hybrid" for Hybrid strategy.')
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

if rs_alpha(1)  % Random sampling
    alpha = rs_alpha(2);

    prob_mat = ((1-alpha) .* weight_mat) ./ total_sum;

    card = numel(Space);  % number of elements
    not_aligned = card - nnz(weight_mat) + n_samples;
    
    for ii = 1:size(Space,1)
        for jj = 1:size(Space,2)
            % ii -> rows, jj -> columns
            % If it is not a pivot
            if sum(ismember(samples,[ii jj],'rows')) ~= 1
                if prob_mat(ii,jj) == 0
                    prob_mat(ii,jj) = alpha / (card-not_aligned);
                end
            end
        end
    end
else
    prob_mat = weight_mat ./ total_sum;
end

% plot_probabilities(X,Y,prob_mat);

% As the sampling is without replacing, only the elements with probability
% greater than zero of the `prob_mat` matrix can be chosen
if new_budget > nnz(prob_mat)
    warning('Only as many new samples can be generated as elements with probability greater than 0. %i samples created',nnz(prob_mat))
    nb = nnz(prob_mat);
else
    nb = new_budget;
end

% Random number stream
s = RandStream('mlfg6331_64');
ind = datasample(s,1:length(prob_mat(:)),nb,'Replace',false,'Weights',prob_mat(:));
[row,col] = ind2sub(size(prob_mat),ind);

% for i = 1:new_budget
%     disp([row(i) col(i) prob_mat(row(i),col(i))])
% end

end

