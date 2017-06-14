a=[1/2 1/2 1/2];
p=rgb2xyz(a);
p_norm=p/sum(p(:))
q=my_rgb2xyz(a);
q_norm=q/sum(q(:))
isequal(p_norm,q_norm)

pa=xyz2rgb(p)
qa=my_xyz2rgb(q)
isequal(pa,qa)