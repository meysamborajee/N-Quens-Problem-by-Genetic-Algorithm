function i=Select(p)

    C=cumsum(p);
    n=numel(p);
    r=rand;
    i=find(r<=C,1,'first');
%     for i=1:n
%         if r<=C(i)
%             return;            
%         end
%     end

end