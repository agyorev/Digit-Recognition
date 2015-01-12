To run the script just call the `main.m` MATLAB script file.

I am using the formula:

               W = Y^T * X * (R * c * I)^-1 , (*)
               
to compute the weights for the linear classifier.

I have the following set of features:

**cross_feature:** consideres the dot product of the current image, with the
               'perfect' representation of the digits (i.e. the representation
               which results when you average the grey values for each pixel of
               the training set for each digit). This features measures in a way
               the similarity of the tested digit and the perfect written one.

**row/col_stripe_feature:** this features examines every strip the image (row and 
                        column wise) and counts the number of strips that it 
                        intercepts, given certain threshold value. That is so
                        because as the first features measures similarity in a
                        way, this should take care if the digit is skewed in some
                        firection for example.

**bfs_feature:** I use this feature to examine the closed regions (islands) of the 
             image, excluding the ones that are touching the borders. It should
             help with distinguishing between 0 and 8, for example, since both of
             them have a similar shape, however, 0 has only one 'island' and 8
             has 2.

**intensity_feature:** Here I break the image into 4x5 quadrant blocks, indexed 1
                   through 12, where we have 4 rows of 3 such blocks on each, 
                   and I compute the average grey scale value in each one of
                   those. This feature should account again in a way for the 
                   relative structure of the digits, where some skewness and
                   unaccuracy is expected within the blocks.

With the `compute_feature_vectors.m` script I have tried to make the feature
engineering (addition, removal, modification) as modular as possible, where we
can have an external script computing different features, and in the `compute_feature_vectors.m` 
script we just put together the building blocks.

I use 10-fold cross-valudation (`find_best_tychonov.m`) for the normalization 
coefficient `c` for (*), the result of which over the test portion of the training
data set you can find in `cross-valudation.jpg`.

Running the `main.m` script with the coefficient we got from the x-validation
yields error rate of **3.3%**, where we have no error when recognizing 2 and 7, but
we have the most at 3, 5 and 8, which look similar to some extend.
