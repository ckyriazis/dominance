#! /usr/bin/env python
# script for 1000 genomes EUR DFE workflow
# we want to model a discrete DFE with more than one dominance coefficient

import dadi
import numpy
import scipy
import pickle
import sys
import Selection #make sure Selection.py is copied into working dir
import sys
import pandas as pd
import numpy as np

directory_spectra = "/u/home/c/ckyriazi/project-klohmuel/dominance_inference/spectra"
directory_results = "/u/home/c/ckyriazi/project-klohmuel/dominance_inference/output_hs"


# Taking the parameters out
times = 5
h1 = sys.argv[1] # 0.1, 1e-2
h2 = sys.argv[2] # 1e-2, 1e-3
h3 = sys.argv[3] # 1e-3, 1e-4
h4 = sys.argv[4] # 1e-4, 1e-5
h5 = sys.argv[5] # 1e-5, 0
syn_sfs_dir = '/u/home/c/ckyriazi/project-klohmuel/dominance_inference/data/1kG_syn.csv'
nonsyn_sfs_dir = '/u/home/c/ckyriazi/project-klohmuel/dominance_inference/data/1kG_nonsyn.csv'
outputfile = 'spectra_results_h_{c1}_{c2}_{c3}_{c4}_{c5}.txt'.format(c1=h1, c2=h2, c3=h3, c4=h4, c5=h5)



########################################################
# Demographic inference
########################################################


def eur_demog(params, ns, pts):
	"""
	generic european/asian demographic model
	bottleneck -> recovery -> exponential growth
	"""
	N1, T1, N2, T2, NC, TC = params
	dadi.Integration.timescale_factor = 0.001
	xx = dadi.Numerics.default_grid(pts)
	phi = dadi.PhiManip.phi_1D(xx)
	phi = dadi.Integration.one_pop(phi, xx, T1, N1)
	phi = dadi.Integration.one_pop(phi, xx, T2, N2)
	dadi.Integration.timescale_factor = 0.000001
	nu_func = lambda t: N2*numpy.exp(numpy.log(NC/N2)*t/TC)
	phi = dadi.Integration.one_pop(phi, xx, TC, nu_func)
	fs = dadi.Spectrum.from_phi(phi, ns, (xx,))
	return fs

#load 1000 genomes synonymous SFS
syn_sfs = numpy.genfromtxt(syn_sfs_dir,delimiter=",")
syn_sfs = dadi.Spectrum(syn_sfs)
syn_sfs = syn_sfs.fold()

#set initial parameter guesses, convert to coalescent units
Nanc = 10085.
N1 = 2111.693671/(2*Nanc)
N2 = 22062.08869/(2*Nanc)
NC = 652465.1415/(2*Nanc)
T1 = 0.01 #T1 bottleneck time is fixed !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
T2 = (1553.2561-235.47597)/(2*Nanc)
TC = 235.47597/(2*Nanc)

#setup dadi optimization stuff
pts_l = [1000, 1400, 1800]
func = eur_demog
func_ex = dadi.Numerics.make_extrap_log_func(func)
params = [N1, T1, N2, T2, NC, TC]
lower_bound = [1e-2, 0.01, 1e-2, 1e-3, 1, 1e-3]
upper_bound = [10, 0.01, 10, 0.5, 200, 0.5]
fixed_params = [None, 0.01, None, None, None, None]

# fit demographic model
# need to make sure parameters are a good fit
# i usually run 25-30 runs and make sure they've converged

# randomize starting point
p0 = dadi.Misc.perturb_params(params, upper_bound=upper_bound)
p0[2] = 0.01

# optimize
#popt = dadi.Inference.optimize_log(p0, syn_sfs, func_ex, pts_l, 
#								   lower_bound=lower_bound, 
#								   upper_bound=upper_bound,
#								   fixed_params=fixed_params,
#								   verbose=len(p0), maxiter=30)


#best fit should be similar to
popt=[8.45886500e-02,1.00000000e-02,1.09948173e+00,7.04035448e-02,5.32986095e+01,2.00795456e-02]


print("This is the demographic model")
print(popt)

# compute synonymous theta
theta_s = dadi.Inference.optimal_sfs_scaling(func_ex(popt, syn_sfs.sample_sizes,pts_l),syn_sfs)

print("This is theta synonymous")
print(theta_s)



########################################################
# Generate spectra 
########################################################


# compute Nanc for DFE rescaling
mu = 1.5e-8
Ls = 8058343 # length 
Nanc = theta_s/(4*mu*Ls)

# compute nonsynonymous theta
mut_ratio = 2.31 # mu_ns/mu_s
theta_ns = theta_s * mut_ratio


# parameters for building selection spectra
ns = syn_sfs.sample_sizes

spectra_h_1=pickle.load(open('{directory_spectra}/spectra_h_{coef}.sp'.format(directory_spectra=directory_spectra, coef=h1),'rb'))
spectra_h_2=pickle.load(open('{directory_spectra}/spectra_h_{coef}.sp'.format(directory_spectra=directory_spectra, coef=h2),'rb'))
spectra_h_3=pickle.load(open('{directory_spectra}/spectra_h_{coef}.sp'.format(directory_spectra=directory_spectra, coef=h3),'rb'))
spectra_h_4=pickle.load(open('{directory_spectra}/spectra_h_{coef}.sp'.format(directory_spectra=directory_spectra, coef=h4),'rb'))
spectra_h_5=pickle.load(open('{directory_spectra}/spectra_h_{coef}.sp'.format(directory_spectra=directory_spectra, coef=h5),'rb'))


# Replacing the deleterious part of the spectras under a recessive models
# Replacing bin 1
# s = 0.1, 1
#spectra_h_0_5.spectra[0:1] = spectra_h_0_0.spectra[0:1]

# Replacing the bins with other dominance values (leave the spectra_h1)

# Replacing bin 1
# s = 0.1, 1e-2
print(f"This is bin 1: {h1}")
spectra_h_1.spectra[0:50] = spectra_h_1.spectra[0:50]

# Replacing bin 2
# s = 1e-2, 1e-3
print(f"This is bin 2: {h2}")
spectra_h_1.spectra[50:100] = spectra_h_2.spectra[50:100]

# Replacing bin 3
# s = 1e-3, 1e-4
print("This is bin 3: {h3}")
spectra_h_1.spectra[100:150] = spectra_h_3.spectra[100:150]

# s = 1e-4, 1e-5
print("This is bin 4: {h4}")
spectra_h_1.spectra[150:200] = spectra_h_4.spectra[150:200]

# s = 1e-5, 0
print("This is bin 5: {h5}")
spectra_h_1.spectra[200:250] = spectra_h_5.spectra[200:250]

spectra = spectra_h_1




########################################################
# Fit discrete DFE
########################################################

# load nonsynonymous SFS
nonsyn_sfs = numpy.genfromtxt(nonsyn_sfs_dir,delimiter=",")
nonsyn_sfs = dadi.Spectrum(nonsyn_sfs)
nonsyn_sfs = nonsyn_sfs.fold()

# set up bin DFE
# set up to optimize mass in each bin
# manually set Nanc
# use constrained optimization
def unif_dist_cons(mgamma, a1, a2, a3, a4, a5):
	#made this range overlap with int_breaks for convenience
	#manually set Nanc from above (Nanc = theta_syn/(4*mu*L_s))
	Nanc=12386.
	x0 = 0. * 2 * Nanc
	x1 = 1e-5 * 2 * Nanc
	x2 = 1e-4 * 2 * Nanc
	x3 = 1e-3 * 2 * Nanc
	x4 = 1e-2 * 2 * Nanc
	x5 = 0.5 * 2 * Nanc
	mgamma = -mgamma
	if (mgamma >= x0) and (mgamma < x1):
		return (a1/(x1-x0))
	elif (mgamma >= x1) and (mgamma < x2):
		return (a2/(x2-x1))
	elif (mgamma >= x2) and (mgamma < x3):
		return (a3/(x3-x2))
	elif (mgamma >= x3) and (mgamma < x4):
		return (a4/(x4-x3))
	elif (mgamma >= x4) and (mgamma <= x5):
		return (a5/(x5-x4))
	else:
		return 0

dfe = numpy.frompyfunc(unif_dist_cons, 6, 1)

def cons_func(x, *args):
	return(1-numpy.sum(x))

# set up optimization
lower_bound=[0, 0, 0, 0, 0]
upper_bound=[1, 1, 1, 1, 1]
params = (0.2, 0.2, 0.2, 0.2, 0.2)

discrete_max_likelihoods = []
discrete_guesses = dict()
for i in range(times):
	p0 = dadi.Misc.perturb_params(params, upper_bound=upper_bound)

	popt = Selection.optimize_cons(p0, nonsyn_sfs, spectra.integrate, dfe,
								   theta_ns, lower_bound=lower_bound, 
								   upper_bound=upper_bound, verbose=len(p0),
								   maxiter=25, constraint=cons_func)
	discrete_max_likelihoods.append(popt[0])
	discrete_guesses[popt[0]] = popt

discrete_max_likelihoods.sort()




########################################################
# Outputting guesses 
########################################################

results_discrete = []
print(discrete_guesses.keys())
for i in range(len(discrete_guesses.keys())):
	best_popt_discrete = discrete_guesses[discrete_max_likelihoods[i]]
	results_discrete.append([best_popt_discrete[0], best_popt_discrete[1][0], best_popt_discrete[1][1], best_popt_discrete[1][2], best_popt_discrete[1][3], best_popt_discrete[1][4], h5, h4, h3, h2, h1]) #,  best_popt_discrete[1][4],  best_popt_discrete[1][5]]

# Writing results as csvs:
df_discrete = pd.DataFrame(results_discrete, columns =['Likelihood', 'neut', 'nneut', 'wkdel', 'moddel', 'strdel','h5', 'h4', 'h3', 'h2', 'h1'], dtype = float)
df_discrete.to_csv('{directory_results}/DFE_inference_discrete_{h1}_{h2}_{h3}_{h4}_{h5}.csv'.format(directory_results=directory_results, h1=h1, h2=h2, h3=h3, h4=h4, h5=h5), index=False)

