% Copyright 2016 Sun Yat-Sen University SMIIP Lab, Weitao Wen
% This software is distributed under the terms of the GNU Public License
% version 3 (http://www.gnu.org/licenses/gpl.txt)

% Third Order Differential Beamforming in six microphones microphone array
% Third-order CDMAs can be designed with six or seven microphones.
%
% input: d--distance between microphones
%        f--temporal frequency
% output: view of First Order Dipole Beamforming Pattern

function H = thirdOrder(d, f)

addpath(genpath('../utils'));

w = 2 * pi * f;         % angular frequency
c = 340;                % speed of sound

st_vec1 = getSteeringVector(6, d, w, 0);
st_vec2 = getSteeringVector(6, d, w, pi/2);
st_vec3 = getSteeringVector(6, d, w, 2*pi/3);
st_vec4 = getSteeringVector(6, d, w, pi);
constraint_vec1 = [0 1 0 0 0 -1];
constraint_vec2 = [0 0 1 0 -1 0];
A = [st_vec1'; st_vec2'; st_vec3'; st_vec4'; constraint_vec1; constraint_vec2];
B = [1 0 0 0 0 0];
B = B';
% Designed filter
H = A\B;

% Plot the Beamforming Pattern
num_dot = 100;
theta = linspace(0, 2*pi,num_dot);
for n = 1 : num_dot
    st_vec = getSteeringVector(6, d, w, theta(n));
    BP(n) = st_vec' * H;
    BP(n) = 20*log10(abs(BP(n)));
end
my_polar(theta, BP, -40, 0);
title(['f =', num2str(f),', \delta = ', num2str(d)],'fontsize', 40)
