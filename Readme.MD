Readme
=======
 
This readme explains how the run_analysis.R script works. The script starts by reading in the activity labels data (and naming the columns). It then reads in the list of all features, and subsets the features of interest through a regular expression (grep).

The actual processing then consists of (both for train and test data):
- reading in feature values (X)
- reading in labels (y)
- reading in the subjects
- selecting the needed columns (mean & std)
- cbinding X, y & subjects
- merging the dataset with the previously read activity labels data
- adds an indicator column showing wether it is training or test data

Finally, it rbinds test and training data. Tidying (aggregation) of the data is done with the melt&cast method.