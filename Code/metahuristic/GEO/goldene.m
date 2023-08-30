function [ Best_score , GEO_cg_curve, Best_pos, initime ] = goldene(dataset, maxIterations, pop)

fun = @CrossKNN;
options.PopulationSize = pop;
options.MaxIterations  = maxIterations;

options.AttackPropensity = [0.5 ,   2];
options.CruisePropensity = [1   , 0.5];

options.lb    = 0 .* ones (1,dataset.nvars);
options.ub    = 1 .* ones (1,dataset.nvars);

[Best_pos,Best_score,GEO_cg_curve, initime] = GEO (fun,dataset,options);
                                         

end

