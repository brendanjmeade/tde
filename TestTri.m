% A basic TDE example
close all;
clear all;

% set up the parameters of strike, slip and tensile
pr              = 0.25;
ss              = -1;
ts              = 0;
ds              = 0;
N               = 30;

% Set the observation coordinates and TDE geometry
[sx, sy, sz]    = meshgrid(linspace(0, 100, N), linspace(0, 100, N), 0);
X               = [40; 60; 40];
Y               = [50; 50; 30];
Z               = [0; 0; 20];

% Calculate displacements at surface
U               = CalcTriDisps(sx(:), sy(:), sz(:), X, Y, Z, pr, ss, ts, ds);

% Plot results
figure;
hold on;
xlabel('x (km)');
ylabel('y (km)');
title('Surface displacments');
fill(X, Y, '-g');
set(gca, 'XLim', [min(sx(:)) max(sx(:))]);
set(gca, 'YLim', [min(sy(:)) max(sy(:))]);
quiver3(sx(:), sy(:), sz(:), U.x, U.y, U.z, 3.2, 'b');
