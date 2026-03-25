# setup paths -
const _ROOT = pwd();
const _PATH_TO_DATA = joinpath(_ROOT, "data");
const _PATH_TO_SRC = joinpath(_ROOT, "src");

# check: do we have a data directory?
!isdir(_PATH_TO_DATA) && mkpath(_PATH_TO_DATA);

# load external packages -
using Statistics
using LinearAlgebra
using Random
using DataFrames
using CSV
using Flux
using NNlib
using Plots
using Colors
