%configuration
DELTA_ALPHA_A  = 210;
DELTA_ALPHA_B  = 330;
DELTA_ALPHA_C  = 90;
Z_MAX_LENGTH = 300;
ROD_RADIUS_A = 92;
ROD_RADIUS_B = 92;
ROD_RADIUS_C = 92;

ROD_LENGTH_A = 217;
ROD_LENGTH_B = 217;
ROD_LENGTH_C = 217;
%actuator
z1 = Z_MAX_LENGTH-50;
z2 = Z_MAX_LENGTH-75;
z3 = Z_MAX_LENGTH-100;
function p_e = delta_kinematic(q,config)
    
    %calculation
    p1 = deg_rot_z(DELTA_ALPHA_A)*[ROD_RADIUS_A;0;0]+[0;0;z1];
    p2 = deg_rot_z(DELTA_ALPHA_B)*[ROD_RADIUS_B;0;0]+[0;0;z2];
    p3 = deg_rot_z(DELTA_ALPHA_C)*[ROD_RADIUS_C;0;0]+[0;0;z3];

    %creat plane plane_eq = [a;b;c],plane_const = d
    %ax+by+cz+d = 0
    plane_eq = cross(p2-p1,p3-p1);
    plane_const = -dot(plane_eq,p1);

    %prepare date to create transformation
    plane_center = [0;0;dot(plane_eq,p1)/plane_eq(3)];
    plane_z_rot_ang = acos(plane_eq(3)/norm(plane_eq));
    plane_z_rot_axis = normalize(cross([0;0;1],plane_eq));

    plane_rmat = rot_axis(plane_z_rot_axis,plane_z_rot_ang);

    %create homogeneous transformation matrix
    plane_hmat = [[plane_rmat;[0,0,0]],[plane_center;1]];
    %transform p1,p2,p3
    h_p1 = plane_hmat\[p1;1];
    h_p2 = plane_hmat\[p2;1];
    h_p3 = plane_hmat\[p3;1];
    pp1 = h_p1(1:3);
    pp2 = h_p2(1:3);
    pp3 = h_p3(1:3);

    %find center of endeffector in plane


    v12 = normalize(pp2-pp1);
    v12_c = rot_z(0.5*pi)*v12;
    v13 = normalize(pp3-pp1);
    v13_c = rot_z(0.5*pi)*v13;

    d12 = norm(pp1-pp2);
    d13 = norm(pp1-pp3);
    k12 = (d12^2+ROD_LENGTH_A^2-ROD_LENGTH_B^2)/(2*d12);
    k13 = (d13^2+ROD_LENGTH_A^2-ROD_LENGTH_C^2)/(2*d13);
    pp12 = pp1+k12*v12;
    pp13 = pp1+k13*v13;

    %solve linear cof*var = const
    cof_e = [v12_c(1:2),-v13_c(1:2)];
    const_e = pp13(1:2)-pp12(1:2);
    k_e = cof_e\const_e;
    pp_ce = pp12+v12_c*k_e(1);
    %calculate enfeffector in plane
    pp_eh = -sqrt(ROD_LENGTH_A^2-norm(pp_ce-pp1)^2);

    pp_e = [pp_ce(1:2);pp_eh];

    %transform back
    hp12 = plane_hmat*[pp12;1];
    hp13 = plane_hmat*[pp13;1];
    hp_ce = plane_hmat*[pp_ce;1];
    hp_e = plane_hmat*[pp_e;1];
    p12 = hp12(1:3);
    p13 = hp13(1:3);
    p_ce = hp_ce(1:3);
    p_e = hp_e(1:3);
end
%visualize
hold on;
axis equal
plot_line(plane_center,[0;0;0]);
plot_line(p_ce,p13);
plot_line(p_ce,p_e);
plot_line(p12,p_ce);
plot_tower(p1,p2,p3,Z_MAX_LENGTH);
plot_cariage(p1,p2,p3);
plotFrame(eye(4),20);
plotFrame(plane_hmat,20);
plotEndeffector(p1,p2,p3,p_e)
%recheck
disp(norm(p_e-p1));
disp(norm(p_e-p2));
disp(norm(p_e-p3));
function Rz = deg_rot_z(theta)

theta = deg2rad(theta);
Rz = rot_z(theta);

end
function Rz = rot_z(theta)


c = cos(theta);
s = sin(theta);
Rz = [c -s 0;s c 0;0 0 1];

end