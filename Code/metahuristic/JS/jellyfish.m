

function [ Best_score , cg_curve, Best_pos,initime] = jellyfish(dataset, maxIterations, pop)

fun = @CostFunction;

options.PopulationSize = pop;
options.MaxIterations  = maxIterations;
options.ub = 1;
options.lb = 0;

 
[u,fval,NumEval,fbestvl, popi,initime]=js(fun,dataset,options); 
  
Best_score = fval;
cg_curve = fbestvl;
Best_pos = u;






end

