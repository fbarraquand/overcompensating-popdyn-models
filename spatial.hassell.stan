
data {                // observed variables
  int<lower=1> tmax;  // number of observations
  int<lower=1> I;  // number of sectors
  matrix[tmax,I] x;     // state variable
}
parameters {            // unobserved parameters
  real r;               // growth rate
  real<lower=0> alpha;  // density-dependence
  real<lower=0> beta;   // density-dependence exponent
  real<lower=0> sigma;  // sd noise growth rate
  real<lower=0> sigma_T;  // sd purely temporal noise
}
model {
  real nu[tmax];
  
  //priors
  r ~ normal(0,1);
  alpha ~ exponential(10);
  beta ~ exponential(10);
  sigma_T ~ exponential(10);
  sigma ~ exponential(10);
  
  //likelihood
 for (t in 1:(tmax-1)){
  nu[t] ~ normal(0,sigma_T);
  for (i in 1:I){
         x[t+1,i] ~ normal(r+x[t,i] + nu[t] -beta*log(1+alpha*exp(x[t,i])),sigma);
      }
  }
  
}

