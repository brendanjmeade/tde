function Stress = StrainToStress(Strain, lambda, mu)
% StressToStrain.m
%
% Calculate stresses and invariants given a strain tensor and elastic
% moduli lambda and mu.
%
% This paper should and related code should be cited as:
% Brendan J. Meade, Algorithms for the calculation of exact 
% displacements, strains, and stresses for Triangular Dislocation 
% Elements in a uniform elastic half space, Computers & 
% Geosciences (2007), doi:10.1016/j.cageo.2006.12.003.
%
% Use at your own risk and please let me know of any bugs/errors!
%
% Copyright (c) 2006 Brendan Meade
% 
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to permit
% persons to whom the Software is furnished to do so, subject to the
% following conditions:
% 
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
% NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
% OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
% USE OR OTHER DEALINGS IN THE SOFTWARE.

Stress.xx = 2.*mu.*Strain.xx + lambda.*(Strain.xx+Strain.yy+Strain.zz);
Stress.yy = 2.*mu.*Strain.yy + lambda.*(Strain.xx+Strain.yy+Strain.zz);
Stress.zz = 2.*mu.*Strain.zz + lambda.*(Strain.xx+Strain.yy+Strain.zz);
Stress.xy = 2.*mu.*Strain.xy;
Stress.xz = 2.*mu.*Strain.xz;
Stress.yz = 2.*mu.*Strain.yz;
Stress.I1 = Stress.xx + Stress.yy + Stress.zz;
Stress.I2 = -(Stress.xx.*Stress.yy + Stress.yy.*Stress.zz + Stress.xx.*Stress.zz) + Stress.xy.*Stress.xy + Stress.xz.*Stress.xz + Stress.yz.*Stress.yz;
Stress.I3 = Stress.xx.*Stress.yy.*Stress.zz + 2.*Stress.xy.*Stress.xz.*Stress.yz - (Stress.xx.*Stress.yz.*Stress.yz + Stress.yy.*Stress.xz.*Stress.xz + Stress.zz.*Stress.xy.*Stress.xy);


