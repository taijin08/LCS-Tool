% poincare_closed_orbit_multi Find closed orbits of multiple Poincare
% sections
%
% SYNTAX
% [closedOrbits,orbits] = poincare_closed_orbit_multi(flow,shearline,PSList,odeSolverOptions,dThresh,showGraph)
%
% INPUT ARGUMENTS
% PSList: 1-by-n struct of Poincare sections
% Format of PSList
% PSList(i).endPosition: [endPosition1x,endPosition1y;endPosition2x,endPosition2y];
% PSList(i).numPoints: number of initial positions along Poincare section
% from which closed orbit candidates will be launched
% PSList(i).orbitMaxLength: maximum length allowed for closed orbits.
% Limits integration time.
% showGraph: logical, set true to show plots of Poincare sections
%
% OUTPUT
% closedOrbits{}{}: Positions of closed orbits
% Format of closeOrbits
% closedOrbits{i}{1}{1}: innermost closed orbit around Poincare section i in
% etaPos field
% closedOrbits{i}{2}{end}: outermost closed orbit around Poincare section i in
% etaNeg field
% orbits{}{}{}: Positions of all orbits
% Format: orbits{1}{2}{3}: 3rd {3} orbit of 1st {1} Poincare section in
% etaNeg {2} field

function [closedOrbits,orbits] = poincare_closed_orbit_multi(flow,shearline,PSList,odeSolverOptions,dThresh,showGraph)

narginchk(5,6)
if nargin == 5
    showGraph = false;
end

nPoincareSection = numel(PSList);
closedOrbits = cell(1,nPoincareSection);
orbits = cell(1,nPoincareSection);

nBisection = 5;

for i = 1:nPoincareSection
    % define current Poincare section
    poincareSection.endPosition = PSList(i).endPosition;
    poincareSection.numPoints = PSList(i).numPoints;
    poincareSection.integrationLength = [0,PSList(i).orbitMaxLength];
    
    % find outermost orbit of each Poincare section
    [closedOrbitsPos,orbitsPos] = poincare_closed_orbit(flow,shearline.etaPos,poincareSection,odeSolverOptions,nBisection,dThresh,showGraph);
    closedOrbits{i}{1} = closedOrbitsPos;
    orbits{i}{1} = orbitsPos;
    
    % find outermost orbit of each Poincare section
    [closedOrbitsNeg,orbitsNeg] = poincare_closed_orbit(flow,shearline.etaNeg,poincareSection,odeSolverOptions,nBisection,dThresh,showGraph);
    closedOrbits{i}{2} = closedOrbitsNeg;
    orbits{i}{2} = orbitsNeg;    
end
