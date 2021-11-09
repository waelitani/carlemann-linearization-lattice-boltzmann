figure('DefaultAxesFontSize',14,'Name','Carlemann Linearization of Logistic Equation','WindowState','Maximized','DefaultLineLineWidth', 2);

colors = ['#0072BD';'#D95319';'#EDB120';'#7E2F8E';'#77AC30'];

subplot(2,2,2);
hold on;
xlabel('Time (sec)');
ylabel('x');


whichT = 1;
plot((0:time).*dt,fResults{whichT},'DisplayName','Exact','Color','k');

for o = 1:length(order)
    if (order(o) < 10)
        st = ':';
        lw = 1;
        mm = 'none';
    else
        st = '-';
        lw = 1.5;
        mm = 'x';
    end
    plot((0:time).*dt,VResults{o,whichT},'DisplayName',['N = ',num2str(order(o))],'LineStyle',st,'Marker',mm,'MarkerIndices',1:(1/dt):time,'LineWidth',lw,'Color',colors((mod(o,size(colors,1))>0)*(mod(o,size(colors,1)))+(mod(o,size(colors,1))==0)*(5),:));
end

axis([0 time*dt 0 2]);
yline(1, 'r--','DisplayName','Asymptote');
title('Numerical Solution');
xticks(0:1:5);

subplot(2,2,1);
hold on;

xlabel('Time (sec)');
ylabel('x');


syms("a(t)");
aSol = dsolve(diff(a) == subs(omega,f,a), a(0) == f0);
dat = eval(subs(aSol,t,(0:time).*dt));

plot((0:time).*dt,dat,'DisplayName','Exact','Color','k');

axis([0 time*dt 0 2]);


for o = 1:length(order)
    if (order(o) < 10)
        st = ':';
        lw = 1;
        mm = 'none';
    else
        st = '-';
        lw = 1.5;
        mm = 'x';
    end
    plot((0:time).*dt,eval(subs(analyticSol{o,initCond+1},t,(0:time).*dt)),'DisplayName',['Oc = ',num2str(order(o))],'LineStyle',st,'Marker',mm,'MarkerIndices',1:(1/dt):time,'LineWidth',lw,'Color',colors((mod(o,size(colors,1))>0)*(mod(o,size(colors,1)))+(mod(o,size(colors,1))==0)*(5),:));
end

yline(1, 'r--','DisplayName','Asymptote');
title('Analytical Solution');
xticks(0:1:5);

Q = 1;

titleQ = {'Population'};

%stopAt = length(time);
stopAt = 0;
stopOrder = length(order);

    subplot(2,2,4);

for q = 1:1:Q


    if (q == 1)
        ylabel('Normalized Error');
    end

    for o = 1:1:stopOrder
    if (order(o) < 10)
        st = ':';
        lw = 1;
        mm = 'none';
    else
        st = '-';
        lw = 1.5;
        mm = 'x';
    end
        plot((0:time-stopAt).*dt,abs(VResults{o,whichT}(q,1:end-stopAt)-fResults{whichT}(q,1:end-stopAt))./abs(fResults{whichT}(q,1:end-stopAt)),'DisplayName',['Oc = ',num2str(order(o))],'LineStyle',st,'Marker',mm,'MarkerIndices',1:(1/dt):time,'LineWidth',lw,'Color',colors((mod(o,size(colors,1))>0)*(mod(o,size(colors,1)))+(mod(o,size(colors,1))==0)*(5),:));
            hold on;
    end

    axis([0 time*dt 0 1]);

end

subplot(2,2,3);

for q = 1:1:Q

    

    if (q == 1)
        ylabel('Normalized Error');
    end

    for o = 1:1:stopOrder
    if (order(o) < 10)
        st = ':';
        lw = 1;
        mm = 'none';
    else
        st = '-';
        lw = 1.5;
        mm = 'x';
    end
        plot((0:time-stopAt).*dt,abs(eval(subs(analyticSol{o,initCond+1},t,(0:time).*dt))-fResults{whichT}(q,1:end-stopAt))./abs(fResults{whichT}(q,1:end-stopAt)),'DisplayName',['Oc = ',num2str(order(o))],'LineStyle',st,'Marker',mm,'MarkerIndices',1:(1/dt):time,'LineWidth',lw,'Color',colors((mod(o,size(colors,1))>0)*(mod(o,size(colors,1)))+(mod(o,size(colors,1))==0)*(5),:));
        hold on;
    end

    axis([0 time*dt 0 1]);

end

    
legend('Orientation','horizontal','Position',[0.2175 0.865 0.6 0.05]);

suptitle({'Carlemann Linearization of Logistic Equation',['Initial condition x(t = 0) = ',num2str(f0),' | Timestep ',num2str(dt), ' sec',' | K ',num2str(T(whichT))]});

print([num2str(f0),'.0.ps.png'],'-dpng');
