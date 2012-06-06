function is_position_outside_domain(position,domain)

nStrainlines = size(position,2);
positionXMin = min(arrayfun(@(i)min(position{i}(:,1)),1:nStrainlines));
positionXMax = max(arrayfun(@(i)max(position{i}(:,1)),1:nStrainlines));
positionYMin = min(arrayfun(@(i)min(position{i}(:,2)),1:nStrainlines));
positionYMax = max(arrayfun(@(i)max(position{i}(:,2)),1:nStrainlines));

if positionXMin < domain(1)
    warning('LcsTool:shearlineOutsideDomain',...
        ['Shearline position outside domain, xMin = ',...
        num2str(positionXMin)]);
end

if positionXMax > domain(3)
    warning('LcsTool:shearlineOutsideDomain',...
        ['Shearline position outside domain, xMax = ',...
        num2str(positionXMax)]);
end

if positionYMin < domain(2)
    warning('LcsTool:shearlineOutsideDomain',...
        ['Shearline position outside domain, yMin = ',...
        num2str(positionYMin)]);
end

if positionYMax > domain(4)
    warning('LcsTool:shearlineOutsideDomain',...
        ['Shearline position outside domain, yMax = ',...
        num2str(positionYMax)]);
end

end