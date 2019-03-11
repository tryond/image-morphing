% Morphing Script

%% Load Images

% load in source and target images
I1 = im2double(imread('start_image.jpg'));
I2 = im2double(imread('end_image.jpg'));
    
%% Choose First Correspondences

% get corresponding points
% I1: pts_img1
% I2: pts_img2
cpselect(I1, I2); 

% save ref_points.mat pts_img1 pts_img2
% load ref_points.mat

%% Add corners to point matrices

% set height and width
[h,w,~] = size(I1);

% add corners to both source and target points
pts_img1 = [pts_img1' [0 0]' [w 0]' [0 h]' [w h]'];
pts_img2 = [pts_img2' [0 0]' [w 0]' [0 h]' [w h]'];

%% Create halfway point matrix for best triangulation

% generate midpoints for each key pair
pts_halfway = 0.5*pts_img1 + 0.5*pts_img2;

% create point arrays
x_mid = pts_halfway(1,:)';
y_mid = pts_halfway(2,:)';

% create triangulation
tri = delaunay(x_mid,y_mid);
    
%% Create morph sequence

% now produce the frames of the morph sequence
for fnum = 1:61
    t = (fnum-1)/60;
    
    % intermediate key-point locations
    pts_target = (1-t)*pts_img1 + t*pts_img2;
    
    %warp both images towards target
    I1_warp = warp(I1,pts_img1,pts_target,tri);
    I2_warp = warp(I2,pts_img2,pts_target,tri);
        
    % blend the two warped images
    Iresult = (1-t)*I1_warp + t*I2_warp;

    % display frames
    figure(1); clf; imagesc(Iresult); axis image; drawnow;

    % alternately save them to a file to put in your writeup
    % imwrite(Iresult,sprintf('frame_%2.2d.jpg',fnum),'jpg');
    
end
