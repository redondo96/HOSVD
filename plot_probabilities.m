function plot_probabilities(X,Y,prob_mat)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% fig = figure; % crea la figura
% set(fig, 'Position', [100 100 600 400]); % define la posición y el tamaño de la figura
% set(fig, 'PaperPosition', [0 0 6 4]); % define la posición y el tamaño de la figura en el papel

% subplot(1,2,1)
contour(X,Y,prob_mat)
% axis square
% title('')

% subplot(1,2,2)
mesh(X,Y,prob_mat)
% axis square
% % title('')

% hold off

end

