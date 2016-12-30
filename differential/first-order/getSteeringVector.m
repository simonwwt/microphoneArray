% Copyright 2016 Sun Yat-Sen University SMIIP Lab, Weitao Wen
% This software is distributed under the terms of the GNU Public License
% version 3 (http://www.gnu.org/licenses/gpl.txt)

% Calculate the steering vector with given azimuth angle
% in a specific circular microphone array.
%
% input: num--number of microphones
%        d--distance between microphones
%        w--angular frequency
%        theta--azimuth angle
% output: steering vector

function [steeringVector] = getSteeringVector(num, d, w, theta)

c = 340;                % speed of sound

for i = 1:num
    phi(i) = 2*pi*(i-1)/num;
    theta_vec(i) = theta;
end

steeringVector = 1i*w*d*cos(theta_vec - phi)/c;
steeringVector = conj(exp(steeringVector));

end

