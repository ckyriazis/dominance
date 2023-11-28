
import os
import itertools


# h1 =  # 0.5, 1e-2
# h2 =  # 1e-2, 1e-3
# h3 =  # 1e-3, 1e-4
# h4 =  # 1e-4, 1e-5
# h5 =  # 1e-5, 0
#list_hs = ["0.00", "0.05", "0.10", "0.15", "0.20", "0.25", "0.30", "0.35", "0.40", "0.45", "0.50"]

list_hs = ["0.00", "0.05", "0.10", "0.15", "0.25", "0.35", "0.45", "0.50"]


perms = itertools.product(list_hs, repeat=4)


for perm in perms:
	#print(perm)
        h1 = str(perm[0])
        h2 = str(perm[1])
        h3 = str(perm[2])
        h4 = str(perm[3])
        h5 = str("0.50")
        print(h1, h2, h3, h4, h5)
        command = 'python run_DFE_inference_hs.py ' + h1 + ' ' + h2 + ' ' + h3 + ' ' + h4 + ' ' + h5
        os.system(command)  

