function [figureHandle, titleHandle] = ...
  InitializeFigure(figureSize, titleString)

xPosFig = 100; yPosFig = 100;
figurePosition = [0 0 figureSize figureSize] + [xPosFig yPosFig xPosFig yPosFig];

figureHandle = figure;
set(figureHandle, 'Position', figurePosition);
colormap('summer')
caxis([0 1])
titleHandle = title(titleString);
hold on

colorbar;

end