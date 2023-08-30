function [ Best_score , cg_curve, Best_pos, initime ] = DE(dataset, maxIterations, pop)

initime = 0;

problem = ypea_problem();

problem.type = 'max';

problem.vars = ypea_var('x', 'real', 'size', dataset.nvars, 'lower_bound', 0, 'upper_bound', 1);

problem.obj_func = @(sol) CrossKNN(dataset.data, dataset.lable ,sol.x );

de = ypea_de();

de.max_iter = maxIterations;
de.pop_size = pop;

% Crossover Probability
de.crossover_prob = 0.7;



de.beta_min = 0.1;
de.beta_max = 0.9;
de.crossover_prob = 0.1;

best_sol = de.solve(problem);

Best_score = best_sol.obj_value ;
Best_pos = best_sol.solution.x;
cg_curve = de.best_obj_value_history;
         
end
