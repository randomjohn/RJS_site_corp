data {
  int ndates;
  vector[ndates] flights;
}

parameters {
  real mu;
  real<lower=0> sigma;
}

model {
  flights ~ normal(mu,sigma);
  mu ~ normal(32,10);
  sigma ~ uniform(0,20);
}
