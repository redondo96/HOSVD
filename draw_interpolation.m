function draw_interpolation(X,Y,x,y,s)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

z = griddata(x,y,s,X,Y,"natural");
plot3(x,y,s,'.r','markersize',10)
hold on
mesh(X,Y,z)
hold off

legend('Samples','Reconstructed function','Location','best')

end

