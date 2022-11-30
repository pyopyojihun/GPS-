function[vec_sat]=Rotation(vec_sat,STT)

ome_E = 7.2921151467e-5;

ro=ome_E*STT;

re=[cos(ro), sin(ro), 0; -sin(ro), cos(ro), 0; 0, 0, 1];

vec_sat=re*vec_sat';

vec_sat=vec_sat';

end