function dist=dist_p2p(posi,p_n)
dist=zeros(p_n,p_n);
for iii=1:p_n
    for jjj=1:p_n
        dist(iii,jjj)=((posi(iii,1)-posi(jjj,1))^2+(posi(iii,2)-posi(jjj,2))^2)^0.5;
    end
end
end