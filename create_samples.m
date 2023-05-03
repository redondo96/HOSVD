function [x,y,s] = create_samples(X,Y,Space,indexes)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n_samples = size(indexes,1);

x = zeros(1,n_samples);
y = zeros(1,n_samples);
s = zeros(1,n_samples);
for i = 1:n_samples
    x(i) = X(indexes(i,1),indexes(i,2));
    y(i) = Y(indexes(i,1),indexes(i,2));
    s(i) = Space(indexes(i,1),indexes(i,2));
end

end

