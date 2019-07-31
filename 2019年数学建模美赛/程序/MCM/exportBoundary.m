cntr = shaperead('./boundary/PRI_adm0.shp','UseGeoCoords',false);
M = [cntr.X',cntr.Y'];
% coastline = rmmissing(coastline);
idx = all(isnan(M),2);
idy = 1 + cumsum(idx);
idz = 1 : size(M,1);
C = accumarray(idy(~idx),idz(~idx),[],@(r){M(r,:)});
coastline = C{59};
save('coastline.mat', 'coastline');