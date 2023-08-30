%_________________________________________________________________________________
%  Heap-based optimizer inspired by corporate rank hierarchy for global
%  optimization source codes version 1.0
%
%  Developed in MATLAB R2015a
%
%  Author and programmer: Qamar Askari
%
%         e-Mail: l165502@lhr.nu.edu.pk
%                 syedqamar@gift.edu.pk
%
%
%   Main paper:
%   Askari, Q., Saeed, M., & Younas, I. (2020). Heap-based optimizer
%   inspired by corporate rank hierarchy for global optimization.
%   Expert Systems with Applications, 2020,
%____________________________________________________________________________________


function [Leader_score,Leader_pos,Convergence_curve, initime]= HBO (fun,dataset,options)

cycles = options.cycles;
degree = options.degree;
searchAgents = options.SearchAgents_no;
Max_iter = options.Max_iteration ;
lb = options.lb;
ub = options.ub;
dim = dataset.nvars;
treeHeight = ceil((log10(searchAgents * degree - searchAgents + 1)/log10(degree))); %Starting from 1
fevals = 0;

% initialize position vector and score for the leader
Leader_pos=zeros(1,dim);
Leader_score=-inf; %change this to -inf for maximization problems

tic();
%Initialize the positions of search agents
Solutions = initialization(searchAgents,dim,ub,lb);

initime = toc;
%Fitness calculation of initial population - Assuming problem of
%minimization
fitnessHeap = zeros(searchAgents, 2) + -inf; %Dim1 fitness(key), Dim2 index(value)

ourvar = degree-2;
%Building initial heap
for c = 1:searchAgents
    fitness = fun(dataset.data,dataset.lable,Solutions(c,:));
    fevals = fevals +1;
    fitnessHeap(c, 1) = fitness;
    fitnessHeap(c, 2) = c;
    
    %Heapifying
    t = c;
    while t > ourvar
        parentInd = floor((t+1)/degree);
        if fitnessHeap(t, 1) <= fitnessHeap(parentInd,1)
            break;
        else
            tempFitness = fitnessHeap(t,:);
            fitnessHeap(t,:) = fitnessHeap(parentInd,:);
            fitnessHeap(parentInd,:) = tempFitness;
        end
        t = parentInd;
    end
    
    if fitness >= Leader_score
        Leader_score = fitness;
        Leader_pos = Solutions(c,:);
    end
end

%Main loop
%Generating collegues limits to make algorithm faster
colleaguesLimits = colleaguesLimitsGenerator(degree,searchAgents);
Convergence_curve=zeros(1,Max_iter);
itPerCycle = Max_iter/cycles;
qtrCycle = itPerCycle / 4;

for it=1:Max_iter
   
    gamma = (mod(it, itPerCycle)) / qtrCycle;
    gamma = abs(2-gamma);
    
    for c = searchAgents:-1:(ourvar+1)
        
        if c == 1 %Dealing with root
            continue;
        else
            parentInd = floor((c+1)/degree);
            curSol = Solutions(fitnessHeap(c,2), :); %Sol to be updated
            parentSol = Solutions(fitnessHeap(parentInd,2), :); %Sol to be updated with reference to
            
            if colleaguesLimits(c,2) > searchAgents
                colleaguesLimits(c,2) = searchAgents;
            end
            colleagueInd = c;
            while colleagueInd == c
                colleagueInd = randi([colleaguesLimits(c,1) colleaguesLimits(c,2)]);
            end
            colleagueSol = Solutions(fitnessHeap(colleagueInd,2), :); %Sol to be updated with reference to
            
            %Position Updating
            for j = 1:dim
                p1 =  (1 - it/(Max_iter));
                p2 = p1+(1- p1)/2;
                r = rand();
                rn = (2*rand()-1);
                
                if r < p1      %To skip any dim to update
                    continue;
                elseif  r < p2
                    D = abs(parentSol(j) - curSol(j));
                    curSol(1, j) = parentSol(j) + rn * gamma * D;
                else
                    if fitnessHeap(colleagueInd,1) < fitnessHeap(c,1)
                        D = abs(colleagueSol(j) - curSol(j));
                        curSol(1, j) = colleagueSol(j) + rn * gamma * D;
                    else
                        D = abs(colleagueSol(j) - curSol(j));
                        curSol(1, j) = curSol(j) + rn * gamma * D;
                    end
                end
            end
        end
        
        % Return back the search agents that go beyond the boundaries of the search space
        Flag4ub=curSol(1, :)>ub;
        Flag4lb=curSol(1, :)<lb;
        curSol(1, :)=(curSol(1, :).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        %Fitness evaluation
        newFitness = fun(dataset.data,dataset.lable,curSol);

        fevals = fevals +1;
        if newFitness > fitnessHeap(c,1)
            fitnessHeap(c,1) = newFitness;
            Solutions(fitnessHeap(c,2), :) = curSol;
        end
        if newFitness > Leader_score
            Leader_score = newFitness;
            Leader_pos = curSol;
        end
        
        %Heapifying
        t = c;
        while t > ourvar
            parentInd = floor((t+1)/degree);
            if fitnessHeap(t, 1) <= fitnessHeap(parentInd,1)
                break;
            else
                tempFitness = fitnessHeap(t,:);
                fitnessHeap(t,:) = fitnessHeap(parentInd,:);
                fitnessHeap(parentInd,:) = tempFitness;
            end
            t = parentInd;
        end
    end
    format long
    Convergence_curve(it)=Leader_score;
    [fevals Leader_score];
end

end

