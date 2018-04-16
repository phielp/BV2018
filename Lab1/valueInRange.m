% Returns a value closest to a specified range if specified
% current value falls outside the range.
function nearest = valueInRange(min, max, value)

    if (value >= min) && (value <= max)
        nearest = value;
    else
        if value < min
            nearest = min;
        else
            nearest = max;
        end
     end
end