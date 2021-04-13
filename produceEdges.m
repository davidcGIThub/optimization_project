edges = zeros(45,2);
edge_counter = 1;
for i = 1:9
    for j = i+1:10
        edges(edge_counter,1) = i;
        edges(edge_counter,2) = j;
        edge_counter = edge_counter + 1;
    end
end