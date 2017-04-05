% Submitter: tryond(tryon, daniel) 20621204

function I_target = warp(I_source,pts_source,pts_target,tri)
%
% I_source : color source image  (HxWx3)
% pts_source : coordinates of keypoints in the source image  (2xN)
% pts_target : coordinates of where the keypoints end up after the warp (2xN)
% tri : list of triangles (triples of indices into pts_source)  (Kx3)
%       for example, the coordinates of the Tth triangle should be
%       given by the expression:
%
%           pts_source(:,tri(T,:))
%
%
% I_target : resulting warped image, same size as source image (HxWx3)
%

% set height and width
[h,w,d] = size(I_source);

% only dealing with RGB source images
assert(d == 3)  

% set number of triangles
num_tri = size(tri,1);

% assert pts_source and pts_target are 2 x n
assert(size(pts_source,1) == 2)
assert(size(pts_target,1) == 2)

% compute transformation for each triangle in target
T = zeros(3,3,num_tri); 
for t = 1:num_tri
    
    % source, target: 2x3 matrices
    source = pts_source(:, tri(t,:));
    target = pts_target(:, tri(t,:));
    
    % source = T * target
    T(:,:,t) = ttform(target, source);
    
end

% tindex(i,j): what triangle t does pixel(i,j) fall into?
tindex = zeros(h,w);
for t = 1:num_tri
    
    % get the 3 corners of this triangle t
    corners = pts_target(:,tri(t,:));
    
    % create mask from corners
    mask = poly2mask(corners(1,:),corners(2,:),h,w);
    
    % all mask(i,j) == 1, are in triangle t
    tindex(mask) = t;   
    
end

% visualize the result to make sure it looks reasonable.
%{
figure(1); clf;

subplot(1,2,1);
imagesc(I_source); axis image; hold on;
for t = 1:num_tri
    source_tri = pts_source(:,tri(t,:));
    plot(source_tri(1,:),source_tri(2,:),'g-');
end
hold off;
title('source triangulation');

subplot(1,2,2);
imagesc(tindex); axis image; hold on;
for t = 1:num_tri
    target_tri = pts_target(:,tri(t,:));
    plot(target_tri(1,:),target_tri(2,:),'r-');
end
hold off;
title('target triangulation');
%}

% coordinates of pixels in target image
[xx,yy] = meshgrid(1:w,1:h);
Xtarg = [xx(:) yy(:) ones(h*w,1)]';

% create list (subscripts) from tindex matrix (indices)
ptlist = reshape(tindex,[1, h*w]);

% Xsrc(:,i) is the source of Xtarg(:,i) in source image
Xsrc = zeros(size(Xtarg));

% transform Xtarg to get Xsrc (by each triangle t)
for t = 1:num_tri
    
    % all subscripts that are applicable to t
    point_mask = ptlist == t;
    
    % create mask to filter out inelligible pixels
    tri_mask = [point_mask;point_mask;point_mask];
    
    % apply transformation to all in Xtarg
    all_trans = T(:,:,t) * Xtarg;
    
    % filter out those that are not in triangle t
    tri_trans = tri_mask.*all_trans;
    
    % add transformed locations to source matrix
    Xsrc = Xsrc + tri_trans;
    
end
    
    % interpolate pixel values from the source
    R = interp2(I_source(:,:,1),Xsrc(1,:),Xsrc(2,:),'spline');
    G = interp2(I_source(:,:,2),Xsrc(1,:),Xsrc(2,:),'spline');
    B = interp2(I_source(:,:,3),Xsrc(1,:),Xsrc(2,:),'spline');
    
    % synthesize final image
    I_target = zeros(h,w,3);
    I_target(:,:,1) = reshape(R,h,w);
    I_target(:,:,2) = reshape(G,h,w);
    I_target(:,:,3) = reshape(B,h,w);
        
    
    
    
    
