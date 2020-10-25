clc;
clear all;
close all;
%%
Nq=input('Please insert number of chessboard :');

Npop=40;
Maxit=150;
pm=0.5;                        % mutation ratio
pc=0.7;                         % crossover ratio
nc=round(pc*Npop/2)*2;          % number of parents (also offsprings)

nm=round(pm*Npop);              % number of mutants
individual.Position=zeros(1,Nq); 
individual.Cost=[];
pop=repmat(individual,Npop,1);
Bestpop=repmat(individual,1);
Bestcosts=zeros(Maxit,1);
tic;

%% Initial Solution
for i=1:Npop
    pop(i).Position=randperm(Nq);
    % Cost calculation
    pop(i).Cost=0;
    for j=1:Nq-1
        for k=j+1:Nq
            if (abs(pop(i).Position(j)-pop(i).Position(k)) == abs(j-k))
                pop(i).Cost=pop(i).Cost+1;
            end
        end
    end
end


%% Main Loop
for it=1:Maxit

    % sorting the population according to the costs values
    [costs,ind]=sort([pop.Cost]);
    pop=pop(ind(1:Npop),1);        % WAS: pop=pop(ind,:);
    costs=costs(1:Npop);
    
    % update Bestpop and Bestcosts
    Bestpop(1)=pop(1,1);
    Bestcosts(it)=costs(1);
    %% display
    PlotQueen(Bestpop,Nq)
    % display results
    disp(['Iteration ' num2str(it) ':   Best Cost = ' num2str(Bestcosts(it))]);
    if it==Maxit
        break;
    end
    
    
    % fitness calculation
    ff=exp(-costs./10);
    
    % selection probabilities
    P1=ff/sum(ff);
    
    %% crossover
    ii=zeros(nc/2,2);
    for kk=1:nc
        ii(kk)=Select(P1);
    end
    pop2=repmat(individual,nc+nm,1);
    for kk=1:nc/2
        p1=pop(ii(kk,1));
        p2=pop(ii(kk,2));
        alpha=randi([2 Nq],1);
        pop2(2*kk-1).Position=Crossover( p1.Position(1,1:alpha),p2.Position,Nq,alpha );
        pop2(2*kk).Position=Crossover( p2.Position(1,1:alpha),p1.Position,Nq,alpha );
        % Cost calculation
         pop2(2*kk-1).Cost=0;
         pop2(2*kk).Cost=0;
        for j=1:Nq-1
            for k=j+1:Nq
                if (abs( pop2(2*kk-1).Position(j)- pop2(2*kk-1).Position(k)) == abs(j-k))
                    pop2(2*kk-1).Cost= pop2(2*kk-1).Cost+1;
                end
                if (abs( pop2(2*kk).Position(j)- pop2(2*kk).Position(k)) == abs(j-k))
                    pop2(2*kk).Cost= pop2(2*kk).Cost+1;
                end
            end
        end
        
    end
    
    %% mutation    
    for kk=1:nm
        pop2(nc+kk).Position=pop(randi(numel(pop))).Position;
        sel=randperm(Nq,2);
        sav=pop2(nc+kk).Position(1,sel(1));
        pop2(nc+kk).Position(1,sel(1))=pop2(nc+kk).Position(1,sel(2));
        pop2(nc+kk).Position(1,sel(2))=sav;
        
        % Cost calculation
         pop2(nc+kk).Cost=0;
        for j=1:Nq-1
            for k=j+1:Nq
                if (abs( pop2(nc+kk).Position(j)- pop2(nc+kk).Position(k)) == abs(j-k))
                    pop2(nc+kk).Cost= pop2(nc+kk).Cost+1;
                end
            end
        end
    end
    pop=cat(1,pop,pop2);
    if it > 80
        if  Bestcosts(it)== Bestcosts(it-80)
            for l = it + 1:Maxit
                Bestcosts(l) =Bestcosts(l-1);
            end
            break;
        end
    end 
    
end
toc;

