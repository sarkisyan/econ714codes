# README file for econ714 codes

Folder "PS1" contains files for the problem set 1:

- File "ps1_integration.R" codes quadrature and MC integration for problem 2
- File "ps1_optimization.R" codes optimization using Newton, BFGS, steepest descent, and conjugate descent methods for problem 3
- File "ps1_pareto.R" codes planner's solution using NLOPT (https://nlopt.readthedocs.io/en/latest/) for problem 4
- File "ps1_price.R" codes solution for prices for problem 5
- File "ps1_results.pdf" contains a description of results

Folder "PS2" contains files for the problem set 2:

- Files that start with "VFI" code value function iterations (standard, accelerator, and multigrid) for problems 1-4
- File "Chebyshev.m" codes Chebyshev polynomials for problem 5 and makes use of multiple other files (described in the header)
- File "neuralnet.R" codes deep learning for problem 7

Folder "final project" contains files for the replication of Gomes, Jermann, and Schmid (AER 2016)

- Folder "VFI code" codes value function iterations for the firm's problem to obtain the derivative of the price w.r.t. debt
- Folder "dynare" contains Dynare code to solve the model using perturbations. IRFs are to the TFP and monetary shock (as in the paper)
