data {
  int ndates;
  int flights[ndates]; // changed to array of integers
  int qtr[ndates];
  int dow[ndates];
}

parameters {
  real mu;
  real<lower=0> phi; // no longer sigma - phi is overdispersion
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
  flights ~ neg_binomial_2_log(mu + qtr_effect[qtr] + dow_effect[dow],phi); // changed distribution
  phi ~ uniform(0,50000); // phi is no longer a variance but an overdispersion
  mu ~ normal(3.45,2);
  for (i in 1:3)
    qtr_effect[i] ~ normal(0,2);
  for (i in 1:6)
    dow_effect[i] ~ normal(0,2);
}
