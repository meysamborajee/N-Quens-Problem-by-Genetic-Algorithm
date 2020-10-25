function PlotQueen(Bestpop,Nq)

y=zeros(2,Nq);
    for i=1:Nq
        y(i,1:2)=[i,Bestpop.Position(i)];
    end
    plot(y(:,1),y(:,2),'bo','MarkerSize',40/((Nq)^(.5)),'MarkerFaceColor',[0 0 0]);
    grid on;
    set(gca,'Xlim',[0.5 Nq+0.5],'Ylim',[0.5 Nq+0.5],'XTick',0.5:1:Nq+1,'YTick',0.5:1:Nq+1)
    pause(0.001);
end