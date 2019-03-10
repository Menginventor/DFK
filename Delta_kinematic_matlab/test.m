syms ux uy uz theta

u = [ux;uy;uz];
uu = [u u u];
uxu = uu.*uu.';
x_axis = [1 ;0 ;0];
y_axis = [0 ;1 ;0];
z_axis = [0 ;0 ;1];
disp(rot_axis(y_axis,theta));