This directory contains code for SVD-based dimensionality reduction methods.

Algorithms:

* `featureSelection`: Algorithm in *Unsupervised Feature Selection for the k-means Clustering Problem*.
* `fastsvd`: Algorithm in *An implementation of a randomized algorithm for principal component analysis*, provided by the author.
* `svd_ext`: Algorithm 3 in *Randomized dimensionality resuction for k-means clustering*.

Helper scripts:

* `dokmeans`: Run our algorithm on the NIPS dataset.
* `runorl`: Run our algorithm on the ORL dataset.
* `runpuerkmeans`: Run *k*-means algorithm without dimensionality-reduction.

* `calc_result`: A helper function to calculate P and F for the NIPS dataset.
* `prep`: Preprocess the NIPS dataset.
* `prep_orl`: Preprocess the ORL dataset.
* `plot_data`: Draw a 2-dimensional plot about the clustering result.