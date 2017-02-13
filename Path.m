function [SP] = Path(u,v,P,D,SP)

% This function returns the vector SP which corresponds to the sequence of
% graph nodes composing the shortest path from node u to node v given the 
% predecessor matrix P and the final shortest paths distance matrix D.
% Note that vector SP must be initially passed as an empty matrix.

% Get intermediate path vertices.
if(P(u,v)~=0)
    Path(u,P(u,v),P,D,SP);
    SP = [SP,P(u,v)];
    Path(P(u,v),v,P,D,SP);
end;

% Compose full path.
if(P(u,v)~=0)
    SP = [u,SP,v];
else
    if(and((D(u,v)~=0),(D(u,v)~=Inf)))
        SP = [u,v];
    end;
end;

end

