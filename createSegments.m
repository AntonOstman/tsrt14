function [segments] = createSegments(data, segmentLength, overlap)
    stepSize = segmentLength - overlap;
    numSegments = floor((length(data) - overlap) / stepSize);
    
    % Preallocate for speed
    segments = zeros(segmentLength, numSegments);
    
    for i = 1:numSegments
        startIndex = (i - 1) * stepSize + 1 - segmentLength;
        if startIndex < 0
            startIndex = 1;
        end
        endIndex = startIndex + segmentLength - 1;
        if endIndex > size(data, 1)
            endIndex = size(data, 1);
        end
        startIndex
        endIndex
        segments(:, i) = data(startIndex:endIndex);
    end
end
