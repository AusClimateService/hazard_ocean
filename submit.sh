#!/bin/bash
# Script being adapted to compuate MHW and DHW diagnostics with papermill 
#
# will be applied to OAX too.
#

#for ((j1=0; j1<=26; j1+=4)); do
  j1=0
  j2=$((j1 + 0))
  jobfile="ajob_${j1}_${j2}.pbs"

  # Create PBS job script
  cat > $jobfile <<EOF
#!/bin/bash -l
##PBS -P v19
#PBS -P xv83 
## megamem
#PBS -l walltime=18:00:00
#PBS -q megamembw
#PBS -l ncpus=32
##PBS -q megamem
##PBS -l ncpus=48
#PBS -l mem=2990GB
#PBS -l jobfs=300GB  
#PBS -l wd
#PBS -l storage=scratch/xv83+gdata/ia39+gdata/xv83+gdata/dk92+gdata/v14+gdata/v19+gdata/fp2+gdata/xp65+gdata/ik11+gdata/cj50+gdata/e14+gdata/ua8
#PBS -j oe
#PBS -m abe
 
 
module list
#module unload conda/analysis3-24.04
#module load conda/analysis3
#module load dask-optimiser
module load ferret
module use /g/data/xp65/public/modules
module load conda/analysis3
module list
conda env list

# list available kernels
jupyter kernelspec list

# compute Diagnostics information

#papermill1 -k python3  mhw_threshold.ipynb output/out_threshold_sst.ipynb 
#papermill1 -k python3 -p oax_var PH  oa_threshold.ipynb output/out_threshold_PH.ipynb 
#papermill1 -k python3 -p oax_var OAR oa_threshold.ipynb output/out_threshold_OAR.ipynb 
#papermill -k python3 -p oax_var hco3r oa_h_threshold.ipynb output/out_threshold_OAR.ipynb 

papermill -k python3 -p oax_var hco3r oax_cal-h.ipynb output/out_hco3r_oax.ipynb  
#papermill1 -k python3 -p oax_var OAR oax_cal.ipynb output/out_OAR_oax.ipynb  
#papermill1 -k python3 -p oax_var PH oax_cal.ipynb output/out_PH_oax.ipynb  
#papermill mhw_cal.ipynb output/out_mhw.ipynb -k python3 
#papermill dhw_cal.ipynb output/out_dhw.ipynb -k python3 

EOF

# Submit the job
 qsub $jobfile

