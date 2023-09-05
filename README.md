# MCM
A Robust Map Matching Method by Considering Memorized Multiple Matching Candidates [pdf download](https://www.sciencedirect.com/science/article/pii/S0304397522006387)

## test.m  
main program

## lcsg_q
main algorithm
- findnear.m Find near edge
- weightfunc.m Define the weight function

Follow-up work can mainly modify these two

## plot_record.m
To visualize the results, note that the score matrix defined here is very large, so if you save it, you need to modify the matlab statement

## dataset
- global dataset [link](https://zenodo.org/record/57731)
- Washington dataset [link](https://www.microsoft.com/en-us/research/publication/hidden-markov-map-matching-noise-sparseness/)
