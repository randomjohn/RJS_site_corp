data {
  int ndates;
  vector[ndates] flights;
  int qtr[ndates];
  int dow[ndates];
}

parameters {
  real<lower=0> sigma;
  vector[4] qtr_effect;
  vector[7] dow_effect;
}

model {
  flights ~ normal(qtr_effect[qtr] + dow_effect[dow],sigma);
  sigma ~ uniform(0,20);
  for (i in 1:4)
    qtr_effect[i] ~ normal(32,10);
  for (i in 1:7)
    dow_effect[i] ~ normal(0,10);
}