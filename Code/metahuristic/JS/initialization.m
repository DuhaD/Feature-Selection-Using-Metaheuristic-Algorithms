%% This function is used for initialization population by logistic chaos map
%-----------------------------------------------------------------------------------------------------------------%
%  Jellyfish Search Optimizer (JS) source codes demo version 1.0  Developed in MATLAB R2016a                      %
%  Author and programmer:                                                                                         %
%         Professor        Jui-Sheng Chou                                                                         %
%         Ph.D. Candidate  Dinh- Nhat Truong                                                                      %
%  Paper: A Novel Metaheuristic Optimizer Inspired By Behavior of Jellyfish in Ocean,                             %
%         Applied Mathematics and Computation. Computation, Volume 389, 15 January 2021, 125535.                  %
%  DOI:   https://doi.org/10.1016/j.amc.2020.125535                                                               %
%                                     PiM Lab, NTUST, Taipei, Taiwan, July-2020                                   %
%-----------------------------------------------------------------------------------------------------------------%
% The equations can be referred to the below paper:                                                               %
% I. Fister, M. Perc, S.M. Kamal, I. Fister, A review of chaos-based firefly algorithms:                          %
% Perspectives and research challenges,                                                                           %
% Applied Mathematics and Computation 252 (2015) 155-165, https://doi.org/10.1016/j.amc.2014.12.006.
              % %  Mai Abujazoh 9210103
%-----------------------------------------------------------------------------------------------------------------%
function pop=initialization(num_pop,nd,Ub,Lb)

if size(Lb,2)==1
    Lb=Lb*ones(1,nd);
    Ub=Ub*ones(1,nd);
end
x(1,:)=rand(1,nd);
a=4;
%X i+1 = ηX i ( 1 −X i ) , 0 ≤X 0 ≤1
for i=1:(num_pop-1)
    x(i+1,:)=a*x(i,:).*(1-x(i,:));
end 
for k=1:nd
    for i=1:num_pop
        pop(i,k)=Lb(k)+x(i,k)*(Ub(k)-Lb(k));
    end
end
end