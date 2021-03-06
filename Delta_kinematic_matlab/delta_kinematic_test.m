%configuration
DELTA_ALPHA_A  = 210;
DELTA_ALPHA_B  = 330;
DELTA_ALPHA_C  = 90;


ROD_RADIUS_A = 92;
ROD_RADIUS_B = 92;
ROD_RADIUS_C = 92;

ROD_LENGTH_A = 217;
ROD_LENGTH_B = 217;
ROD_LENGTH_C = 217;
DELTA_ALPHA = [DELTA_ALPHA_A;DELTA_ALPHA_B;DELTA_ALPHA_C];
ROD_RADIUS = [ROD_RADIUS_A;ROD_RADIUS_B;ROD_RADIUS_C];
ROD_LENGTH = [ROD_LENGTH_A;ROD_LENGTH_B;ROD_LENGTH_C];
config = [DELTA_ALPHA,ROD_RADIUS,ROD_LENGTH];
Z_MAX_LENGTH = 300;

%actuator
%q = [50;75;100];
syms q1 q2 q3
q = [q1;q2;q3];
[p_e,p1,p2,p3,plane_hmat] = DFK2(q,config,Z_MAX_LENGTH);
%visualize
hold on;
axis equal


plot_tower(p1,p2,p3,Z_MAX_LENGTH);
plot_cariage(p1,p2,p3);
plotFrame(eye(4),20);
plotFrame(plane_hmat,20);
plotEndeffector(p1,p2,p3,p_e)


%recheck
disp(norm(p_e-p1));
disp(norm(p_e-p2));
disp(norm(p_e-p3));
