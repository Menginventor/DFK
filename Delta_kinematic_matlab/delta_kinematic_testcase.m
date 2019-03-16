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
%ceps = 1e-12;
cesp = eps;
hold on;
axis equal


plot_tower(p1,p2,p3,Z_MAX_LENGTH);

plotFrame(eye(4),20);

iterate = 0;
for q1 = 0:10:100
    for q2 = 0:10:100
        for q3 = 0:10:100
            disp(iterate);
            iterate = iterate+1;
            q = [q1;q2;q3];
            [p_e,p1,p2,p3] = DFK2(q,config,Z_MAX_LENGTH);
            %scatter3(p_e(1),p_e(2),p_e(3));
            %plotEndeffector(p1,p2,p3,p_e)
            if (norm(p_e-p1)- ROD_LENGTH_A>ceps )
                disp('error p1');
                disp(q);
                disp(norm(p_e-p1)- ROD_LENGTH_A)
                disp(eps)
            elseif  (norm(p_e-p2)-ROD_LENGTH_B>ceps)
                disp('error p2');
                disp(q);
                disp(norm(p_e-p2)-ROD_LENGTH_B)
                disp(eps)
 
            elseif  (norm(p_e-p3)-ROD_LENGTH_C>ceps)
                disp('error p3');
                disp(q);
                disp(norm(p_e-p3)-ROD_LENGTH_C);
                disp(eps);
 
            
            end
            if isnan(p_e)
                disp('nan');
                disp(q);
            end
        end
    end
end
%visualize




