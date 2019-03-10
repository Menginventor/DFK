function plot_tower (p1,p2,p3,z_max)

p1_L = [p1(1:2);0];
p2_L = [p2(1:2);0];
p3_L = [p3(1:2);0];
p1_H = [p1(1:2);z_max];
p2_H = [p2(1:2);z_max];
p3_H = [p3(1:2);z_max];
plot_line(p1_L,p1_H);
plot_line(p2_L,p2_H);
plot_line(p3_L,p3_H);
plot_line(p1_L,p2_L);
plot_line(p1_L,p3_L);
plot_line(p2_L,p3_L);
plot_line(p1_H,p2_H);
plot_line(p1_H,p3_H);
plot_line(p2_H,p3_H);
end
