#! /usr/bin/env python
# script for 1000 genomes EUR DFE workflow

import dadi
import numpy
import scipy
import pickle
import sys
import Selection #make sure Selection.py is copied into working dir
import sys
import pandas as pd


# Taking the parameters out
times = 25
h_coefficient = sys.argv[1]
syn_sfs_dir = sys.argv[2]
nonsyn_sfs_dir = sys.argv[3]



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
infilename = syn_sfs_dir
syn_sfs = numpy.genfromtxt(infilename,delimiter=",")
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
theta_s = dadi.Inference.optimal_sfs_scaling(func_ex(popt, syn_sfs.sample_sizes, pts_l),syn_sfs)

print("This is theta synonymous")
print(theta_s)

# compute Nanc for DFE rescaling
mu = 1.5e-8
Ls = 8058343 # length 
Nanc = theta_s/(4*mu*Ls)

# compute nonsynonymous theta
mut_ratio = 2.31 # mu_ns/mu_s
theta_ns = theta_s * mut_ratio





########################################################
# create spectra object
########################################################

# demographic model
def eur_demog_sel(params, ns, pts):
	"""
	Demographic model with selection
	"""
	dadi.Integration.timescale_factor = 0.001
	N1, T1, N2, T2, NC, TC, gamma = params
	xx = dadi.Numerics.default_grid(pts)
	phi = dadi.PhiManip.phi_1D(xx, gamma=gamma, h=h_coefficient)
	phi = dadi.Integration.one_pop(phi, xx, T1, N1, gamma=gamma)
	phi = dadi.Integration.one_pop(phi, xx, T2, N2, gamma=gamma)
	dadi.Integration.timescale_factor = 0.000001
	nu_func = lambda t: N2*numpy.exp(numpy.log(NC/N2)*t/TC)
	phi = dadi.Integration.one_pop(phi, xx, TC, nu_func, gamma=gamma)
	fs = dadi.Spectrum.from_phi(phi, ns, (xx,))
	return fs

# set int_breaks
# assume everything >0.1 is not seen in the sample
int_breaks=[0.1, 1e-2, 1e-3, 1e-4, 1e-5]

# convert to gamma scale
int_breaks = [x*2*Nanc for x in int_breaks]
s1, s2, s3, s4, s5 = int_breaks

# make sure this is tiny relative to gamma -- minimize trapz integration error
eps = 1e-5
# do a custom vector of gammas
gamma_list = []
gamma_list = numpy.append(gamma_list, -numpy.logspace(numpy.log10(s1), numpy.log10(s2), 50))
gamma_list = numpy.append(gamma_list, -numpy.logspace(numpy.log10(s2-eps), numpy.log10(s3), 50))
gamma_list = numpy.append(gamma_list, -numpy.logspace(numpy.log10(s3-eps), numpy.log10(s4), 50))
gamma_list = numpy.append(gamma_list, -numpy.logspace(numpy.log10(s4-eps), numpy.log10(s5), 50))
gamma_list = numpy.append(gamma_list, -numpy.logspace(numpy.log10(s5-eps), numpy.log10(eps), 50))

print("This is the gamma list")
print(gamma_list)
# parameters for building selection spectra
ns = syn_sfs.sample_sizes

# copy Selection.py to working dir before running this code
# this takes a while
#spectra = Selection.spectra(popt, ns, eur_demog_sel, pts_l=pts_l, 
#							gamma_list=gamma_list, echo=True, mp=False, n=Nanc) #, cpus=30)
# you may receive a warning
# WARNING:Numerics:Extrapolation may have failed. Check resulting frequency 
# spectrum for unexpected results.
# 
# this results from small number numerical errors. you can check the most
# deleterious SFS (spectra.spectra[0]) to make sure there are no problematic
# values (i.e. large negative numbers). it's ok if there are negative numbers
# ~0

#pickle spectra object to use later so you don't have to wait for spectra
#object generation step in subsequent runs
#pickle.dump(spectra, open('dominance_spectra/spectra_h_{coef}.sp'.format(coef=h_coefficient),'wb'))
spectra=pickle.load(open('spectra/spectra_h_{coef}.sp'.format(coef=h_coefficient),'rb'))
#print(spectra)

# load nonsynonymous SFS
infilename = nonsyn_sfs_dir
nonsyn_sfs = numpy.genfromtxt(infilename,delimiter=",")
nonsyn_sfs = dadi.Spectrum(nonsyn_sfs)
nonsyn_sfs = nonsyn_sfs.fold()




########################################################
# Gamma DFE inference
########################################################

# fit a gamma DFE
dfe=Selection.gamma_dist
lower_bound=[1e-3, 1]
upper_bound=[100,100000]
params = (0.2, 1000)


gamma_max_likelihoods = []
gamma_guesses = dict()
for i in range(times):
	p0 = dadi.Misc.perturb_params(params, upper_bound=upper_bound)
	popt = Selection.optimize_log(p0, nonsyn_sfs, spectra.integrate, dfe,
									 theta_ns, lower_bound=lower_bound, 
									 upper_bound=upper_bound, verbose=len(p0),
									 maxiter=25)
	gamma_max_likelihoods.append(popt[0])
	gamma_guesses[popt[0]] = popt


results_gamma = []
print(gamma_guesses.keys())
for i in range(len(gamma_guesses.keys())):
	best_popt_gamma = gamma_guesses[gamma_max_likelihoods[i]]
	results_gamma.append([best_popt_gamma[0], best_popt_gamma[1][0], best_popt_gamma[1][1]]) 

# Writing results as csvs:
df_gamma = pd.DataFrame(results_gamma, columns =['Likelihood', 'alpha', 'beta'], dtype = float) #,
df_gamma.to_csv('output/DFE_inference_gamma_{h}.csv'.format(h=h_coefficient), index=False)

# print SFS
with open('output/SFS_gamma_{h}.txt'.format(h=h_coefficient), 'w') as f:
        for i in range(len(gamma_guesses.keys())-1):
                best_popt_gamma = gamma_guesses[gamma_max_likelihoods[i]]
                expected_sfs = spectra.integrate(best_popt_gamma[1], Selection.gamma_dist, theta_ns)
                f.write('The expected SFS is: {0}.\n\n'.format(expected_sfs))




########################################################
# Discrete DFE inference
########################################################


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


results_discrete = []
print(discrete_guesses.keys())
for i in range(len(discrete_guesses.keys())):
	best_popt_discrete = discrete_guesses[discrete_max_likelihoods[i]]
	results_discrete.append([best_popt_discrete[0], best_popt_discrete[1][0], best_popt_discrete[1][1], best_popt_discrete[1][2], best_popt_discrete[1][3], best_popt_discrete[1][4]]) #,  best_popt_discrete[1][4],  best_popt_discrete[1][5]]

# Writing results as csvs:
df_discrete = pd.DataFrame(results_discrete, columns =['Likelihood', '0 < |s| <= 1e-5', '1e-5 < |s| <= 1e-4', '1e-4 < |s| <= 1e-3', '1e-3 < |s| <= 1e-2', '1e-2 < |s| <= 1'], dtype = float) #, 'alpha', 'beta'
df_discrete.to_csv('output/DFE_inference_discrete_{h}_constrained.csv'.format(h=h_coefficient), index=False)


# print SFS
with open('output/SFS_discrete_{h}.txt'.format(h=h_coefficient), 'w') as f:

        for i in range(len(discrete_guesses.keys())-1):
                best_popt_discrete = discrete_guesses[discrete_max_likelihoods[i]]
                expected_sfs = spectra.integrate(best_popt_discrete[1], numpy.frompyfunc(unif_dist_cons, 6, 1), theta_ns)
                f.write('The expected SFS is: {0}.\n\n'.format(expected_sfs))



