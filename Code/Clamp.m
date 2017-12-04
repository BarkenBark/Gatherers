function x = Clamp(x, minValue, maxValue)
    x = max(minValue, min(maxValue, x));
end

