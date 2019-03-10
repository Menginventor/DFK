function R = rot_axis(axis,angle)

if angle ~= 0
    uu = [axis axis axis];

    uxu = uu.*uu.';

    R = cos(angle)*eye(3)+sin(angle)*cross_mat(axis)+(1-cos(angle))*uxu;
else
    R = eye(3);
end

end
