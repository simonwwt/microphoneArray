% Copyright 2016 Sun Yat-Sen University SMIIP Lab, Weitao Wen
% This software is distributed under the terms of the GNU Public License
% version 3 (http://www.gnu.org/licenses/gpl.txt)

% Second Order Cardioid Differential Beamforming in four microphone circular array
% Second-order CDMAs can be designed with four or five microphones.
%
% input: d--distance between microphones
%        f--temporal frequency
% output: view of First Order Dipole Beamforming Pattern

function H = secondOrderCardioid(d, f)

addpath(genpath('../utils'));

w = 2 * pi * f;         % angular frequency
c = 340;                % speed of sound

st_vec1 = getSteeringVector(4, d, w, 0);
st_vec2 = getSteeringVector(4, d, w, pi/2);
st_vec3 = getSteeringVector(4, d, w, pi);
constraint_vec = [0 1 0 -1];
A = [st_vec'; st_vec2'; st_vec3'; constraint_vec];
B = [1 0 0 0];
B = B';
% Designed filter
H = A\B;

% Plot the Beamforming Pattern
num_dot = 100;
theta = linspace(0, 2*pi,num_dot);
for n = 1 : num_dot
    st_vec = getSteeringVector(4, d, w, theta(n));
    BP(n) = st_vec' * H;
    BP(n) = 20*log10(abs(BP(n)));
end
my_polar(theta, BP, -40, 0);
