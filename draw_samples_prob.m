function draw_samples_prob(X,Y,prob_mat,indexes)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n_samples = size(indexes,1);

xp = zeros(1,n_samples);
yp = zeros(1,n_samples);
pp = zeros(1,n_samples);
for i = 1:n_samples
    xp(i) = X(indexes(i,1),indexes(i,2));
    yp(i) = Y(indexes(i,1),indexes(i,2));
    pp(i) = prob_mat(indexes(i,1),indexes(i,2));
end

mesh(X,Y,prob_mat)
hold on
plot3(xp,yp,pp,'.','MarkerEdgeColor','#FFA500', ...
    'MarkerFaceColor','#FFA500', ...
    'markersize',15)

legend('Probability function','Proposed samples','Location','best')

hold off

end

