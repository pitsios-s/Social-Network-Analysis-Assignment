% Dernika Eirini -> BAPT1509
% Pitsios Stamatis -> BAPT1502
% Xanthopoulos Christos - George -> BAPT1504

function ReportTopNAuthors(MeasureValues, MeasureName, N, authors, ComponentNumber, SortType)

% This function reports the top N authors ranked by the measure identified
% by the input parameter MeasureName. The corresponding measure values are
% stored within the vector MeasureValues. The number of N and the complete
% list of authors names are also given as input to the function.

[SortedValues, SortedIndices] = sort(MeasureValues, SortType);
TopNSortedValues = SortedValues(1:N);
TopNSortedIndices = SortedIndices(1:N);
TopNAuthorsFirstNames = authors(TopNSortedIndices, 3);
TopNAuthorsSurNames = authors(TopNSortedIndices, 2);

% Report Top N Authors' List.
fprintf('Top %d Authors according to %s in component %i\n', N, MeasureName, ComponentNumber);
for k = 1:1:N
    fprintf('%s %s: %f\n', TopNAuthorsSurNames{k}, TopNAuthorsFirstNames{k}, TopNSortedValues(k));
end;

fprintf('\n\n\n');

end
