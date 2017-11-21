function [figureHandle, axisHandle, titleHandle] = ...
  InitializeFigure(figureSize, titleString)

xPosFig = 100; yPosFig = 100;
figurePosition = [0 0 figureSize figureSize] + [xPosFig yPosFig xPosFig yPosFig];
axisSize = 0.8; xPosAx = 0.07; yPosAx = 0.07;

figureHandle = figure;
axisHandle = gca;
set(figureHandle, 'Position', figurePosition);
colormap('summer')
titleHandle = title(titleString);
hold on

end