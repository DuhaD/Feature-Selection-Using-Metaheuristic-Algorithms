
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  Golden Eagle Optimizer (GEO) source codes version 1.0
%  
%  Developed in:	MATLAB 9.6 (R2019a)
%  
%  Programmer:		Abdolkarim Mohammadi-Balani
%  
%  Original paper:	Abdolkarim Mohammadi-Balani, Mahmoud Dehghan Nayeri, 
%					Adel Azar, Mohammadreza Taghizadeh-Yazdi, 
%					Golden Eagle Optimizer: A nature-inspired 
%					metaheuristic algorithm, Computers & Industrial Engineering.
%
%                  https://doi.org/10.1016/j.cie.2020.107050               
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x,fval,ConvergenceCurve,initime] = GEO(fun,dataset,options)

%% initialization

PopulationSize = options.PopulationSize;
MaxIterations = options.MaxIterations;
nvars = dataset.nvars;
lb = options.lb;
ub = options.ub;

ConvergenceCurve  = zeros (1, MaxIterations);

tic();
x = lb + rand (PopulationSize,nvars) .* (ub-lb);
initime = toc;

FitnessScores =[];
for indvi = 1:size(x,1)
FitnessScores(indvi) = fun(dataset.data,dataset.lable,x(indvi,:));
end
% solver-specific initialization
FlockMemoryF = FitnessScores;
FlockMemoryX = x;

AttackPropensity = linspace (options.AttackPropensity(1), options.AttackPropensity(2), MaxIterations);
CruisePropensity = linspace (options.CruisePropensity(1), options.CruisePropensity(2), MaxIterations);

%% main loop

for CurrentIteration = 1 : MaxIterations
    % disp(CurrentIteration);
	% prey selection (one-to-one mapping)
	DestinationEagle = randperm (PopulationSize)';
	
	% calculate AttackVectorInitial (Eq. 1 in paper)
	AttackVectorInitial = FlockMemoryX (DestinationEagle,:) - x;
	
	% calculate Radius
	Radius = VecNorm (AttackVectorInitial, 2, 2);
	
	% determine converged and unconverged eagles
	ConvergedEagles = sum (Radius,2) == 0;
	UnconvergedEagles = ~ ConvergedEagles;
	
	% initialize CruiseVectorInitial
	CruiseVectorInitial = 2 .* rand (PopulationSize, nvars) - 1; % [-1,1]
	
	% correct vectors for converged eagles
	AttackVectorInitial (ConvergedEagles, :) = 0;
	CruiseVectorInitial (ConvergedEagles, :) = 0;
	
	% determine constrained and free variables
	for i1 = 1 : PopulationSize
		if UnconvergedEagles (i1)
			vConstrained = false ([1, nvars]); % mask
			idx = datasample (find(AttackVectorInitial(i1,:)), 1, 2);
			vConstrained (idx) = 1;
			vFree = ~vConstrained;
			CruiseVectorInitial (i1,idx) = - sum(AttackVectorInitial(i1,vFree).*CruiseVectorInitial(i1,vFree),2) ./ (AttackVectorInitial(i1,vConstrained)); % (Eq. 4 in paper)
		end
	end
	
	% calculate unit vectors
	AttackVectorUnit = AttackVectorInitial ./ VecNorm (AttackVectorInitial, 2, 2);
	CruiseVectorUnit = CruiseVectorInitial ./ VecNorm (CruiseVectorInitial, 2, 2);
	
	% correct vectors for converged eagles
	AttackVectorUnit(ConvergedEagles,:) = 0;
	CruiseVectorUnit(ConvergedEagles,:) = 0;
	
	% calculate movement vectors
	AttackVector = rand (PopulationSize, 1) .* AttackPropensity(CurrentIteration) .* Radius .* AttackVectorUnit; % (first term of Eq. 6 in paper)
	CruiseVector = rand (PopulationSize, 1) .* CruisePropensity(CurrentIteration) .* Radius .* CruiseVectorUnit; % (second term of Eq. 6 in paper)
	StepVector = AttackVector + CruiseVector;
	
	% calculate new x
	x = x + StepVector;
	
	% enforce bounds
	lbExtended = repmat (lb,[PopulationSize,1]);
	ubExtended = repmat (ub,[PopulationSize,1]);
	
	lbViolated = x < lbExtended;
	ubViolated = x > ubExtended;
	
	x (lbViolated) = lbExtended (lbViolated);
	x (ubViolated) = ubExtended (ubViolated);
	
	% calculate fitness
% 	FitnessScores = fun (x,dataset.data,dataset.max_capacity,dataset.nvars);
	FitnessScores =[];
    for indvi = 1:size(x,1)
        FitnessScores(indvi) = fun(dataset.data,dataset.lable,x(indvi,:));
    end
    
	% update memory
	UpdateMask = FitnessScores > FlockMemoryF;
	FlockMemoryF (UpdateMask) = FitnessScores (UpdateMask);
	FlockMemoryX (UpdateMask,:) = x (UpdateMask,:);
	
	% update convergence curve
	ConvergenceCurve (CurrentIteration) = max (FlockMemoryF);
end

%% return values

[fval, fvalIndex] = max (FlockMemoryF);
x = FlockMemoryX (fvalIndex, :);


