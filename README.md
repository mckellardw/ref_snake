# Snakemake workflow to build and organize reference genomes for common alignment tools


## Setup/install
1) Build conda environment (#TODO - automate this!)
   *Note* - installing `gget` with `pip` has given me issues, I recommend using `pip`
```
conda create --name ref_snake -c bioconda star kallisto bowtie bowtie2 minimap2 bwa-mem2
conda activate ref_snake
pip install gget snakemake
conda install -c conda-forge pigz
```

2) Modify `config.yaml` to include what species you want to build refs for
```
SPECIES:
  mus_musculus
  homo_sapiens
```

3) Run pipeline:
```
snakemake -j 16
```

Run pipeline w/ slurm:
```
snakemake --cluster-config slurm_config.yml --cluster "sbatch -p {cluster.partition} -t {cluster.time} -N {cluster.nodes} --mem {cluster.mem} -o {cluster.output} --cpus-per-task={cluster.threads}" -j 32 --cluster-cancel scancel --latency-wait 30
```


## Useful links/resources:
- [`gget` documentation](https://github.com/pachterlab/gget)
- [ensembl]()
- [GENCODE ftp site]()


## TODO
- Tools to add/support:
  - bowtie/2
  - salmon
- Custom references
- GENCODE annotations! (ideally via gget if they add it...)
- ref genome stats?
  
### Misc.
- Download GENCODE references w/ `wget`
```
wget -e robots=off --recursive --no-parent  https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M33
```