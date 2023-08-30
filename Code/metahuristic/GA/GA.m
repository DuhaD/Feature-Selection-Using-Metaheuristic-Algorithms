function [ Best_score , cg_curve, Best_pos, initime ] = GA(dataset, maxIterations, pop)

initime = 0;

problem = ypea_problem();

problem.type = 'max';

problem.vars = ypea_var('x', 'real', 'size', dataset.nvars, 'lower_bound', 0, 'upper_bound', 1);

problem.obj_func = @(sol) CrossKNN(dataset.data, dataset.lable ,sol.x );

ga = ypea_ga();

ga.max_iter = maxIterations;
ga.pop_size = pop;

% Crossover Probability
ga.crossover_prob = 0.7;

% Crossover Inflation Factor
ga.crossover_inflation = 0.4;

% Mutation Probability
ga.mutation_prob = 0.3;

% Mutation Rate
ga.mutation_rate = 0.1;

% Mutation Step Size
ga.mutation_step_size = 0.5;

% Mutation Step Size Damp
ga.mutation_step_size_damp = 0.99;

% Selection Method
ga.selection = 'roulettewheel';

% Selection Pressure
ga.selection_pressure = 5;

ga.display = false;

best_sol = ga.solve(problem);

Best_score = best_sol.obj_value ;
Best_pos = best_sol.solution.x;
cg_curve = ga.best_obj_value_history;
         
end
