function [ Best_score , cg_curve, Best_pos, initime ] = heapbased(dataset, maxIterations, pop)

fun = @CrossKNN;    
options.SearchAgents_no = pop; 
options.Max_iteration  = maxIterations;
options.cycles = floor(maxIterations/25);
options.sv = 100;
options.degree = 3;
options.ub = 1;
options.lb = 0;

[Best_score,Best_pos,cg_curve, initime] = HBO (fun,dataset,options);
         
end

