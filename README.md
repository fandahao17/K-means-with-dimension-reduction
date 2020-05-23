# K-means-with-dimension-reduction

This is the repository for our final project of the [Algorithms for Big Data](http://staff.ustc.edu.cn/~huding/data%20course.html) course at University of Science and Technology of China.

Based on Christos Boutsidis's papers [Random Projections for k-means Clustering](http://papers.nips.cc/paper/3901-random-projections-for-k-means-clustering) and [Unsupervised Feature Selection for the k-means Clustering Problem](http://papers.nips.cc/paper/3724-unsupervised-feature-selection-for-the-k-means-clustering-problem), we looked for ways to apply classical **dimensionality reduction** methods, i.e. [JL-transform](https://en.wikipedia.org/wiki/Johnson–Lindenstrauss_lemma) and [SVD](https://en.wikipedia.org/wiki/Singular_value_decomposition), to the **K-means** clustering problem.

We found some ways to improve the performance of the original methods proposed by Christos and conducted some experiments to evaluated the effectiveness of our improvements. These improvements include:

* Fast JL-transorm to speed up the random projection process.
* Mailman algorithm to make matrix multiplication faster.
* A randomized SVD algorithm to get a highly accurate approximation within little time
* Some thoughts and hypothesis to improve the rescaling process in random feature selection
* Fast and accurate PCA-like feature extraction with only **K** constructed features

This repository contains code and evaluation results for our project. Feel free to check them out and discuss with us!

For more information, please check our [technical report](./report/report.pdf).