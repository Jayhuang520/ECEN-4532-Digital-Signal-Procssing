
Run ompspeedtest command:

Running OMP-Cholesky...
omp: signal 2109 / 8609, estimated remaining time: 00:00:12.33
omp: signal 4234 / 8609, estimated remaining time: 00:00:08.27
omp: signal 6423 / 8609, estimated remaining time: 00:00:04.09
omp: signal 8587 / 8609, estimated remaining time: 00:00:00.04
omp: signal 8609 / 8609

Running Batch-OMP...
omp: signal 3789 / 8609, estimated remaining time: 00:00:01.27
omp: signal 7545 / 8609, estimated remaining time: 00:00:00.28
omp: signal 8609 / 8609

Running Batch-OMP with D'*X specified...
omp: signal 8609 / 8609


Speed summary for 8609 signals, dictionary size 512 x 1000:

Call syntax        Algorithm               Total time
--------------------------------------------------------
OMP(D,X,[],T)      OMP-Cholesky            16.04 seconds
OMP(D,X,G,T)       Batch-OMP                2.30 seconds
OMP(DtX,G,T)       Batch-OMP with D'*X      0.53 seconds
