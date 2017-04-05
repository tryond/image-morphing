% Submitter: tryond(tryon, daniel) 20621204

function T = ttform(tri1,tri2)

% compute the affine transformation T that maps points
% of triangle1 to triangle2
%
%  tri1 : 2x3 matrix containing coordinates of corners of triangle 1
%  tri2 : 2x3 matrix containing coordinates of corners of triangle 2
%
%  T : the resulting transformation, should be a 3x3
%      matrix which operates on points described in
%      homogeneous coordinates
%

% set up homogeneous matrices (3x3 matrices)
source = [tri1; 1 1 1];
target = [tri2; 1 1 1];

% T = target * inv(source)
T = target/source;

% test validity of calculation
err1 = sum((T*[tri1(:,1);1] - [tri2(:,1);1]).^2);
assert(err1 < eps)

err2 = sum((T*[tri1(:,2);1] - [tri2(:,2);1]).^2);
assert(err2 < eps)

err3 = sum((T*[tri1(:,3);1] - [tri2(:,3);1]).^2);
assert(err3 < eps)

