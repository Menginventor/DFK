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
ceps = 1e-13;
hold on;
axis equal


plot_tower(p1,p2,p3,Z_MAX_LENGTH);

plotFrame(eye(4),20);

q1 = 50;
q2 = 50;
q3 = 50;
xlim([-200 200])
ylim([-200 200])
zlim([-10 300])
%q1
while true
    for q1 = 50:1:100
       q = [q1;q2;q3];
       show(q,config,Z_MAX_LENGTH) 
    end
    for q1 = 100:-1:0
       q = [q1;q2;q3];
       show(q,config,Z_MAX_LENGTH) 
    end
    for q1 = 0:1:50
       q = [q1;q2;q3];
       show(q,config,Z_MAX_LENGTH) 
    end
    %q2
    for q2 = 50:1:100
       q = [q1;q2;q3];
       show(q,config,Z_MAX_LENGTH) 
    end
    for q2 = 100:-1:0
       q = [q1;q2;q3];
       show(q,config,Z_MAX_LENGTH) 
    end
    for q2 = 0:1:50
       q = [q1;q2;q3];
       show(q,config,Z_MAX_LENGTH) 
    end
    %q3
    for q3 = 50:1:100
       q = [q1;q2;q3];
       show(q,config,Z_MAX_LENGTH) 
    end
    for q3 = 100:-1:0
       q = [q1;q2;q3];
       show(q,config,Z_MAX_LENGTH) 
    end
    for q3 = 0:1:50
       q = [q1;q2;q3];
       show(q,config,Z_MAX_LENGTH) 
    end
end
   



function show(q,config,Z_MAX_LENGTH)
            [p_e,p1,p2,p3] = DFK(q,config,Z_MAX_LENGTH);
            %scatter3(p_e(1),p_e(2),p_e(3));
            %plotEndeffector(p1,p2,p3,p_e);
            h1 = plot_line(p1,p_e);
            h2 = plot_line(p2,p_e);
            h3 = plot_line(p3,p_e);  
            pause(0.01);
            delete(h1)
            delete(h2)
            delete(h3)
end

