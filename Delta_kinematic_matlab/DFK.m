function [p_e,p1,p2,p3] = DFK(q,config,Z_MAX_LENGTH)
    %configuration
    
    DELTA_ALPHA = config(:,1);
    ROD_RADIUS = config(:,2);
    ROD_LENGTH = config(:,3);
    DELTA_ALPHA_A  = DELTA_ALPHA(1);
    DELTA_ALPHA_B  = DELTA_ALPHA(2);
    DELTA_ALPHA_C  = DELTA_ALPHA(3);

    ROD_RADIUS_A = ROD_RADIUS(1);
    ROD_RADIUS_B = ROD_RADIUS(2);
    ROD_RADIUS_C = ROD_RADIUS(3);

    ROD_LENGTH_A = ROD_LENGTH(1);
    ROD_LENGTH_B = ROD_LENGTH(2);
    ROD_LENGTH_C = ROD_LENGTH(3);


    z1 = Z_MAX_LENGTH-q(1);
    z2 = Z_MAX_LENGTH-q(2);
    z3 = Z_MAX_LENGTH-q(3);
    %calculation
    p1 = deg_rot_z(DELTA_ALPHA_A)*[ROD_RADIUS_A;0;0]+[0;0;z1];
    p2 = deg_rot_z(DELTA_ALPHA_B)*[ROD_RADIUS_B;0;0]+[0;0;z2];
    p3 = deg_rot_z(DELTA_ALPHA_C)*[ROD_RADIUS_C;0;0]+[0;0;z3];

    %creat plane plane_eq = [a;b;c],plane_const = d
    %ax+by+cz+d = 0
    plane_eq = cross(p2-p1,p3-p1);

    plane_const = -dot(plane_eq,p1);

    %prepare data to create transformation
    plane_center = [0;0;-plane_const/plane_eq(3)];
    
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
  
    hp_e = plane_hmat*[pp_e;1];

    p_e = hp_e(1:3);
end
function Rz = deg_rot_z(theta)

theta = deg2rad(theta);
Rz = rot_z(theta);

end
function Rz = rot_z(theta)


c = cos(theta);
s = sin(theta);
Rz = [c -s 0;s c 0;0 0 1];

end