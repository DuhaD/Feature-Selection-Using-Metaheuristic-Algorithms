function [ Best_score , cg_curve, Best_pos , initime] = PSO(dataset, maxIterations, pop)

initime = 0;

problem = ypea_problem();

problem.type = 'max';

problem.vars = ypea_var('x', 'real', 'size', dataset.nvars, 'lower_bound', 0, 'upper_bound', 1);

problem.obj_func = @(sol) CrossKNN(dataset.data, dataset.lable ,sol.x );

pso = ypea_pso();

pso.max_iter = maxIterations;
pso.pop_size = pop;

pso.w = 1;
pso.wdamp = 0.99;
pso.c1 = 1.5;
pso.c2 = 2;

pso.display = false;

best_sol = pso.solve(problem);

Best_score = best_sol.obj_value ;
Best_pos = best_sol.solution.x;
cg_curve = pso.best_obj_value_history;
         
end
