% Copyright 2016 Sun Yat-Sen University SMIIP Lab, Weitao Wen
% This software is distributed under the terms of the GNU Public License
% version 3 (http://www.gnu.org/licenses/gpl.txt)

% Superdirective Beamforming with a circular array.
% without any constraint 
%
% input: r--radius of circular microphone array
%        f--temporal frequency
% output: view of First Order Dipole Beamforming Pattern

function maxNulls(r, f)

addpath(genpath('../utils'));

w = 2 * pi * f;         % angular frequency

Ita_dn = getDiffuseNoise(r, w);
st_vec1 = getSteeringVector(6, r, w, 0);
st_vec2 = getSteeringVector(6, r, w, pi/3);
st_vec3 = getSteeringVector(6, r, w, 2*pi/3);
st_vec4 = getSteeringVector(6, r, w, pi);
st_vec5 = getSteeringVector(6, r, w, 4*pi/3);
st_vec6 = getSteeringVector(6, r, w, 5*pi/3);
% Designed filter
C = [st_vec1'; st_vec2'; st_vec3'; st_vec4'; st_vec5'; st_vec6'];
I = [1 0 0 0 0 0]';
H = inv(C)*I;

% Plot the Beamforming Pattern
num_dot = 100;
theta = linspace(0, 2*pi,num_dot);
for n = 1 : num_dot
    st_vec = getSteeringVector(6, r, w, theta(n));
    BP(n) = st_vec' * H;
    BP(n) = 20*log10(abs(BP(n)));
end
my_polar(theta, BP, -40, 0);
