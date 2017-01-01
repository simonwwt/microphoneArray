% Copyright 2016 Sun Yat-Sen University SMIIP Lab, Weitao Wen
% This software is distributed under the terms of the GNU Public License
% version 3 (http://www.gnu.org/licenses/gpl.txt)

% Minimum-Norm First-Order Cardioid Beamforming with a six microphones circular array
%
% input: r--radius of circular microphone array
%        f--temporal frequency
% output: view of First Order Dipole Beamforming Pattern

function H = firstOrderMiniNorm(r, f)

addpath(genpath('../utils'));

w = 2 * pi * f;         % angular frequency
                          
st_vec1 = getSteeringVector(6, r, w, 0);
st_vec2 = getSteeringVector(6, r, w, pi);
C1 = [0 1 0 0 0 -1];
C2 = [0 0 1 0 -1 0];
A = [st_vec1';st_vec2';C1;C2];

B = [1 0 0 0]';
H = A'*inv(A*A')*B;           % A*H = B

% Plot the Beamforming Pattern
num_dot = 100;
theta = linspace(0, 2*pi,num_dot);
for n = 1 : num_dot
    st_vec = getSteeringVector(6, r, w, theta(n));
    BP(n) = st_vec' * H;
    BP(n) = 20*log10(abs(BP(n)));
end
my_polar(theta, BP, -40, 0);
