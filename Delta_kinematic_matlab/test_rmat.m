syms ux uy uz plane_center;
syms p3x p3y p3z;
p3 = [p3x;p3y;p3z];
plane_vec = [ux; uy; uz];
plane_z_axis = plane_vec./norm(plane_vec);
plane_y_axis = (p3-plane_center)./norm((p3-plane_center));
plane_x_axis = cross(plane_y_axis,plane_z_axis);

plane_rmat = [plane_x_axis.';plane_y_axis.';plane_z_axis.'].';
disp(plane_rmat);