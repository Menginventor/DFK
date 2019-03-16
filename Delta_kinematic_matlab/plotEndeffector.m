function h=plotEndeffector (p1,p2,p3,p_e)


h1 = plot_line(p1,p_e);
h2 = plot_line(p2,p_e);
h3 = plot_line(p3,p_e);
h = [h1;h2;h3];
end
