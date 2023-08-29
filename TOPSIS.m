%TOPSIS: Technique for order of preference by similiraty to an ideal solution

clear all
clc
format compact

criterios=3;

BASE=[3 1 2];%vector que representa el plan base

% 1st criterion
POBLACION=[    
37   39   43   10    0   14   46    6    8   40    0   40   36    0   18   25   16   48   33   27   18   30;
27   29   45   39   18   43    0    2    4    7    0   11   15    0   48   25   33   28   21   35   38   18;
42   35   39   20   24   26    7    9    4    0    0   11   15    0   44   40   42   48   25   29   32   18;
];%vector que contiene los planes de mantenimiento resultantes del algoritmo genético de Chu-Beasley

% 2nd criterion
COSTO =[
    865804.250
    860956.625
    855194.625
];%Costo de los individuos de la población

a=size(COSTO);
altern=a(1);

% 3rd criterion
RACIONAMIENTO = [
  145.812
  546.200
  546.200
];%Valor del racionamiento de cada individuo

tamano=size(BASE);

for i=1:altern
    for j=1:tamano(2);
    DIS(i,j)=abs(BASE(j)-POBLACION(i,j));
    end
end 

DISTANCIA=sum(DIS');
sumacuadcosto=0;
sumacuadracion=0;
sumacuaddistancia=0;
 for i=1:altern
   
    sumacuadcosto=sumacuadcosto+(COSTO(i))^2;
    sumacuadracion=sumacuadracion +(RACIONAMIENTO(i))^2;
    sumacuaddistancia=sumacuaddistancia +(DISTANCIA(i))^2;
 end

COSTO_NORMALIZADO=COSTO/sqrt(sumacuadcosto);%Esta matriz calcula el costo normalizado, es decir,
%la matriz COSTO dividida por la raíz de la suma de los cuadrados de los
%costos de las alternativas.

RACIONAMIENTO_NORMALIZADO=RACIONAMIENTO/sqrt(sumacuadcosto');%Esta matriz calcula el racionamiento normalizado, es decir,
%la matriz RACIONAMIENTO dividida por la raíz de la suma de los cuadrados de los
%racionmientos de las alternativas.
DISTANCIA_NORMALIZADO=DISTANCIA'/sqrt(sumacuaddistancia);%Esta matriz calcula la distancia normalizada, es decir,
%la matriz DISTANCIA dividida por la raíz de la suma de los cuadrados de los
%distancias de las alternativas.
W=[0.4 0.5 0.1];

V_COSTO=COSTO_NORMALIZADO*W(1);
V_RACIONAMIENTO=RACIONAMIENTO_NORMALIZADO*W(2);
V_DISTANCIA=DISTANCIA_NORMALIZADO*W(3);

IDEAL=[ min(V_COSTO) min(V_RACIONAMIENTO) min(V_DISTANCIA)];
IDEAL_NEGATIVO=[ max(V_COSTO) max(V_RACIONAMIENTO) max(V_DISTANCIA)];

format long 
   for j=1:altern
       
       D(j)=sqrt((V_COSTO(j)-IDEAL(1))^2+(V_RACIONAMIENTO(j)-IDEAL(2))^2+(V_DISTANCIA(j)-IDEAL(3))^2);
       Dm(j)=sqrt((V_COSTO(j)-IDEAL_NEGATIVO(1))^2+(V_RACIONAMIENTO(j)-IDEAL_NEGATIVO(2))^2+(V_DISTANCIA(j)-IDEAL_NEGATIVO(3))^2);
       
   end
Dplus=D';
Dminus=Dm';
    

for j=1:altern
       
       C(j)=abs(Dminus(j)/(Dplus(j)-Dminus(j)));
      
   end

for x=1:altern
    T(x,1)=x;
    T(x,2)=C(x);
end 
[Ranking,index]=sortrows(T,2);

scatter(T(:,1),T(:,2),'DisplayName','T(:,2) vs. T(:,1)','YDataSource','T(:,2)');figure(gcf)