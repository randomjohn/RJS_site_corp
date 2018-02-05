data {
  int ndates;
  vector[ndates] flights;
  int qtr[ndates];
}

parameters {
  real<lower=0> sigma;
  vector[4] qtr_effect;
}

model {
  flights ~ normal(qtr_effect[qtr],sigma);
  sigma ~ uniform(0,20);
  for (i in 1:4)
    qtr_effect[i] ~ normal(0,10);
}
