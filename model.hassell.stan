
data {                                             // observed variables
  int<lower=1> tmax;                               // number of observations
  vector[tmax] x;                                  // state variable
}
parameters {                                       // unobserved parameters
  real r;                                          // growth rate
  real<lower=0> alpha;                             // density-dependence
  real<lower=0> beta;                              // density-dependence exponent
  real<lower=0> sigma;                             // sd noise growth rate
}
model {
  //priors
  r ~ normal(0,1);
  alpha ~ exponential(10);
  beta ~ exponential(10);
  sigma ~ exponential(10);
  for (t in 1:(tmax-1)){
  x[t+1] ~ normal(r+x[t]-beta*log(1+alpha*exp(x[t])),sigma);
  }
}

