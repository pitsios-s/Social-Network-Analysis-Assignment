function [ BC ] = ComputeBetweennessCentrality( D, P )

    N = size(D, 2);
    
    for i = 1:1:N
        g_i = 0;
        g = 0;
        for j = 1:1:i-1
            for k = i+1:1:N
                if (i ~= j && j ~= k && i ~= k)
                    path = Path(j, k, P, D, []);
                    
                    if (~isempty(path))
                        g = g + 1;
                        
                        if (~isempty(find(path == i)))
                            g_i = g_i + 1;
                        end
                    end
                end
            end
        end
        BC(i) = g_i;
    end

end

