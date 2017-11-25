data {
 int<lower=1> N;
 real responseAlienFirst[N];
 int M;
 int L;
int<lower=1,upper=L> workerid[N];
int<lower=1,upper=M> adjective1[N];
int<lower=1,upper=M> adjective2[N];
vector<lower=-100,upper=100>[N] containsSubjectiveAdjective;
}
parameters {
real<lower=0> alpha;
matrix[2,L]  z_workerid;
matrix[2,M]  z_adjective1;
matrix[2,M]  z_adjective2;
 real beta1;
 real<lower=0, upper=20> sigma_e;
 vector<lower=0>[2] sigmaSlope_workerid;
 vector<lower=0>[2] sigmaSlope_adjective1;
 vector<lower=0>[2] sigmaSlope_adjective2;
 cholesky_factor_corr[2] L_workerid;
 cholesky_factor_corr[2] L_adjective1;
 cholesky_factor_corr[2] L_adjective2;
}
transformed parameters{
 matrix[2,L] for_workerid;
 matrix[2,M] for_adjective1;
 matrix[2,M] for_adjective2;
 for_workerid = diag_pre_multiply(sigmaSlope_workerid,L_workerid) * z_workerid;
 for_adjective1 = diag_pre_multiply(sigmaSlope_adjective1,L_adjective1) * z_adjective1;
 for_adjective2 = diag_pre_multiply(sigmaSlope_adjective2,L_adjective2) * z_adjective2;
}
model {
  real beta_mean;
  real precision;
  real scale1;
  real scale2;
  L_workerid ~ lkj_corr_cholesky(2.0);
  L_adjective1 ~ lkj_corr_cholesky(2.0);
  L_adjective2 ~ lkj_corr_cholesky(2.0);
  to_vector(z_workerid) ~ normal(0,1);
  to_vector(z_adjective1) ~ normal(0,1);
  to_vector(z_adjective2) ~ normal(0,1);
 for (n in 1:N){
   int workeridForN;
   int adjective1ForN;
   int adjective2ForN;
   workeridForN = workerid[n];
   adjective1ForN = adjective1[n];
   adjective2ForN = adjective2[n];
   beta_mean = alpha +for_workerid[1,workeridForN] + for_adjective1[1,adjective1ForN] + for_adjective2[1,adjective2ForN] + containsSubjectiveAdjective[n] * (beta1 + for_adjective1[2,adjective1ForN] + for_workerid[2,workeridForN] + for_adjective2[2,adjective2ForN]);
   precision = sigma_e;
   scale1 = beta_mean*precision;
   scale2 = precision-scale1;
responseAlienFirst[n] ~ beta( scale1 , scale2);
 }
}

