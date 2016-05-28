function TsTris = ReadAndSaveCfm
% ReadAndSaveTsTris.m
%
% This will read all of the .ts files in the current directory
% and save them as in a single structure in a .mat file.
%
% The structure has the form: TsTris.filename.[x y z]
% To access the second x coordinate from the fourteenth
% triangle of the Chino fault try: TsTris.chino(14).x(2)
%
% Copyright Brendan Meade, November 2004
% Use at your own risk!

filestream = 1;
filenames = dir('*.ts');
nFiles = size(filenames, 1);
badFiles = [];
goodFiles = [];
for iFiles = 1:nFiles
   fprintf(filestream, 'Working on %s\n', filenames(iFiles).name);
   try
      Tri = ReadTsCoords(filenames(iFiles).name);
      eval(sprintf('TsTris.%s = Tri;', filenames(iFiles).name(1:end-3)));
      goodFiles = strvcat(goodFiles, filenames(iFiles).name);
   catch
      fprintf(filestream, 'Failed to read %s\n', filenames(iFiles).name);
      badFiles = strvcat(badFiles, filenames(iFiles).name);
   end
end

nGood = size(goodFiles, 1);
nBad = size(badFiles, 1);
fprintf(filestream, 'Tried %d files.  Found %d good and %d bad\n', nFiles, nGood, nBad);
save TsTris.mat TsTris


function Tri = ReadTsCoords(filename)
textDump = textread(filename, '%s', 'delimiter', '\n', 'bufsize', 1e7);
nLines = size(textDump, 1);
[idxVrtx idxPvrtx idxTrgl] = deal(strmatch('VRTX', textDump), strmatch('PVRTX', textDump), strmatch('TRGL', textDump));
idxVrtx = union(idxVrtx, idxPvrtx);
[nVrtx nTrgl] = deal(numel(idxVrtx), numel(idxTrgl));
[Vrtx.l Vrtx.x Vrtx.y Vrtx.z] = deal(zeros(nVrtx, 1), zeros(nVrtx, 1), zeros(nVrtx, 1), zeros(nVrtx, 1));
[Trgl.l1 Trgl.l2 Trgl.l3] = deal(zeros(nTrgl, 1), zeros(nTrgl, 1), zeros(nTrgl, 1));
Tri = repmat(struct('x', [0 0 0], 'y', [0 0 0], 'z', [0 0 0]), nTrgl, 1);

for iVrtx = 1:nVrtx
   stringVrtx = char(textDump(idxVrtx(iVrtx)));
   stringVrtx(isletter(stringVrtx)) = [];
   numVrtx = str2num(stringVrtx);
   [Vrtx.l(iVrtx) Vrtx.x(iVrtx) Vrtx.y(iVrtx) Vrtx.z(iVrtx)] = deal(numVrtx(1), numVrtx(2), numVrtx(3), numVrtx(4));
end

for iTrgl = 1:nTrgl
   stringTrgl = char(textDump(idxTrgl(iTrgl)));
   stringTrgl(isletter(stringTrgl)) = [];
   numTrgl = str2num(stringTrgl);
   [Trgl.l1(iTrgl) Trgl.l2(iTrgl) Trgl.l3(iTrgl)] = deal(numTrgl(1), numTrgl(2), numTrgl(3));
end

for iTrgl = 1:nTrgl
   Tri(iTrgl).x = [Vrtx.x(Trgl.l1(iTrgl)) Vrtx.x(Trgl.l2(iTrgl)) Vrtx.x(Trgl.l3(iTrgl))];
   Tri(iTrgl).y = [Vrtx.y(Trgl.l1(iTrgl)) Vrtx.y(Trgl.l2(iTrgl)) Vrtx.y(Trgl.l3(iTrgl))];
   Tri(iTrgl).z = [Vrtx.z(Trgl.l1(iTrgl)) Vrtx.z(Trgl.l2(iTrgl)) Vrtx.z(Trgl.l3(iTrgl))];
end
