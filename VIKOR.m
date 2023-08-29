%VIKOR: based on an aggregating function representing ‘‘closeness to the ideal’’.


clear all
clc

criterios=3;
W=[0.4 0.5 0.1]; %weight of each criteria
BASE=[3 1 2];%vector que representa el plan base

POBLACION=[    
37   39   43   10    0   14   46    6    8   40    0   40   36    0   18   25   16   48   33   27   18   30;
27   29   45   39   18   43    0    2    4    7    0   11   15    0   48   25   33   28   21   35   38   18;
42   35   39   20   24   26    7    9    4    0    0   11   15    0   44   40   42   48   25   29   32   18;
];%vector que contiene los planes de mantenimiento resultantes del algoritmo genético de Chu-Beasley


COSTO =[
1224734.500
1218879.625
1207353.875
];%Cost of individuals

a=size(COSTO);
altern=a(1);

RACIONAMIENTO = [
  145.812
  546.200
  546.200
];%Rationing value of all individuals

%Procedure to calculate de distance index among individuals and Base Plan
tamano=size(BASE);

for i=1:altern
    for j=1:tamano(2);
    DIS(i,j)=abs(BASE(j)-POBLACION(i,j));
    end
end 

DISTANCIA=sum(DIS');
 
fmas=[ min(COSTO) min(RACIONAMIENTO) min(DISTANCIA)];%Best value of all criterion functions
fmin=[ max(COSTO) max(RACIONAMIENTO) max(DISTANCIA)];%Worst value of all criterion functions

format long 
for j=1:altern
   
   S(j)=W(1)*(fmas(1)-COSTO(j))/(fmas(1)-fmin(1))+W(2)*(fmas(2)-RACIONAMIENTO(j))/(fmas(2)-fmin(2))+W(3)*(fmas(3)-DISTANCIA(j))/(fmas(3)-fmin(3));
  
end

Smin=max(S);
Splus=min(S);

for j=1:altern       
    Aux=[W(1)*(fmas(1)-COSTO(j))/(fmas(1)-fmin(1))  W(2)*(fmas(2)-RACIONAMIENTO(j))/(fmas(2)-fmin(2))  W(3)*(fmas(3)-DISTANCIA(j))/(fmas(3)-fmin(3))];
    R(j)= max(Aux);     
end

Rplus=min(R);
Rmin=max(R);
v=0.5;

for j=1:altern
       
     Q(j)= v*(S(j)-Splus)/(Smin-Splus)+(1-v)*(R(j)-Rplus)/(Rmin-Rplus);
    
end

%This procedure lists the alternative number and the indexes R, S and Q
for x=1:altern
    
    T1(x,1)=x;
    T1(x,2)=R(x);
    
    T2(x,1)=x;
    T2(x,2)=S(x); 
    
    T3(x,1)=x;
    T3(x,2)=Q(x);
    
    
end 
[Ranking1,index1]=sortrows(T1,2);%Ranking according to S index
[Ranking2,index2]=sortrows(T2,2);%Ranking according to R index
[Ranking3,index3]=sortrows(T3,2);%Ranking according to Q index

%Plot of the Pareto Front
hold on
scatter(T1(:,1),T1(:,2),'DisplayName','R(:,2) vs. R(:,1)','YDataSource','R(:,2)');figure(gcf)
scatter(T2(:,1),T2(:,2),'DisplayName','S(:,2) vs. S(:,1)','YDataSource','S(:,2)');figure(gcf)
scatter(T3(:,1),T3(:,2),'DisplayName','Q(:,2) vs. Q(:,1)','YDataSource','Q(:,2)');figure(gcf)

aa_Final = fliplr(index1');
