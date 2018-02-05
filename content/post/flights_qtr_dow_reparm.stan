data {
  int ndates;
  vector[ndates] flights;
  int qtr[ndates];
  int dow[ndates];
}

parameters {
  real mu;
  real<lower=0> sigma;
  vector[3] qtr_effect_raw;
  vector[6] dow_effect_raw;
}

transformed parameters {
  vector[4] qtr_effect;
  vector[7] dow_effect;

  for (i in 1:3)
    qtr_effect[i] = qtr_effect_raw[i];
  qtr_effect[4] = -sum(qtr_effect_raw);
  for (i in 1:6)
    dow_effect[i] = dow_effect_raw[i];
  dow_effect[7] = -sum(dow_effect_raw);
}

model {
  flights ~ normal(mu + qtr_effect[qtr] + dow_effect[dow],sigma);
  sigma ~ uniform(0,20);
  mu ~ normal(32,10);
  for (i in 1:3)
    qtr_effect[i] ~ normal(0,10);
  for (i in 1:6)
    dow_effect[i] ~ normal(0,10);
}
