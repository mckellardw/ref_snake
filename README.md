# `ref_snake`
**A Snakemake pipeline for genomic reference management**


## Setup/install
1) Build mamba/conda environment:
   *Note* - installing `gget` with `conda` has given me issues, I recommend using `pip`
```
mamba create --name ref_snake -f env
mamba activate ref_snake
pip install gget snakemake
mamba install -c conda-forge pigz
```
  *Another note* - if you already have these installed on your system, you can update the executable paths in `config.yml` (`EXEC`) as they are all called using this info

1) Modify `config.yaml` to include what species you want to build refs for
```
SPECIES:
  mus_musculus
  homo_sapiens
```

1) Run pipeline:
```
snakemake --use-conda --conda-frontend mamba -j 16
```

Run pipeline w/ slurm:
```
snakemake --cluster-config slurm_config.yml --cluster "sbatch -p {cluster.partition} -t {cluster.time} -N {cluster.nodes} --mem {cluster.mem} -o {cluster.output} --cpus-per-task={cluster.threads}" -j 32 --cluster-cancel scancel --use-conda --conda-frontend mamba
```

## Output file tree
See `out/README.md` for info on the files output for each species


## Useful links/resources:
- [`gget` documentation](https://github.com/pachterlab/gget)


## TODO
- Tools to add/support:
  - bowtie/2
  - salmon
- Custom references
- GENCODE annotations! (ideally via gget if they add it...)
- ref genome stats?
  
### Misc.
- Download GENCODE references w/ `wget`

Mus musculus:
```
wget -e robots=off --recursive --no-parent  https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/latest_release/
```

optionally, run in the background b/c this takes a while...
```
nohup wget -e robots=off --recursive --no-parent  https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/latest_release > wget_output.log 2>&1 &
```

Homo sapiens:
```
wget -e robots=off --recursive --no-parent  https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/latest_release/
```

optionally, run in the background b/c this takes a while...
```
nohup wget -e robots=off --recursive --no-parent  https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/latest_release/ > wget_output.log 2>&1 &
```