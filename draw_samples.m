function draw_samples(X,Y,Space,x1,y1,s1,x2,y2,s2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

surf(X,Y,Space,'EdgeColor','none')
hold on
plot3(x1,y1,s1,'.r','markersize',10)

if nargin == 9
    
    hold on
    plot3(x2,y2,s2,'.g','markersize',10)

end

hold off

end

