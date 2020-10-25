function [ Ch1 ] = Crossover( Ch1,P2,J,Alpha )

for ii=Alpha+1:J
    if ismember(P2(1,ii),Ch1(1,:))
        for j=1:Alpha
            if ~ismember(P2(1,j),Ch1(1,:))
                Ch1(:,ii)=P2(:,j);
                break;
            end
            
        end
    else
        Ch1(:,ii)=P2(:,ii);
    end

end
%sort(Ch1)
end

