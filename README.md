# Snakemake workflow to build and organize reference genomes for common alignment tools


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
snakemake -j 16
```

Run pipeline w/ slurm:
```
snakemake --cluster-config slurm_config.yml --cluster "sbatch -p {cluster.partition} -t {cluster.time} -N {cluster.nodes} --mem {cluster.mem} -o {cluster.output} --cpus-per-task={cluster.threads}" -j 32 --cluster-cancel scancel --use-conda --conda-frontend mamba
```

## Output file tree
List of all of the files generated for each species (human shown below):
```
ref_snake/out/
├── homo_sapiens
│   ├── genome
│   │   ├── bwa_mem2
│   │   │   ├── genome.fa.0123
│   │   │   ├── genome.fa.amb
│   │   │   ├── genome.fa.ann
│   │   │   ├── genome.fa.bwt.2bit.64
│   │   │   ├── genome.fa.gz
│   │   │   ├── genome.fa.gz.0123
│   │   │   ├── genome.fa.gz.amb
│   │   │   ├── genome.fa.gz.ann
│   │   │   ├── genome.fa.gz.bwt.2bit.64
│   │   │   ├── genome.fa.gz.pac
│   │   │   ├── genome.fa.pac
│   │   │   └── index.log
│   │   ├── kb
│   │   │   ├── cdna.fa
│   │   │   ├── kb_ref.log
│   │   │   ├── t2g.txt
│   │   │   └── transcriptome.idx
│   │   ├── kb_nuc
│   │   │   ├── cdna.fa
│   │   │   ├── cdna.t2c
│   │   │   ├── intron.fa
│   │   │   ├── intron.t2c
│   │   │   ├── kb_ref.log
│   │   │   ├── t2g.txt
│   │   │   └── transcriptome.idx
│   │   ├── kb_velo
│   │   │   ├── cdna.fa
│   │   │   ├── cdna.t2c
│   │   │   ├── intron.fa
│   │   │   ├── intron.t2c
│   │   │   ├── kb_ref.log
│   │   │   ├── t2g.txt
│   │   │   └── transcriptome.idx
│   │   ├── logs
│   │   │   └── metadata.log
│   │   ├── minimap2
│   │   │   ├── mm2.log
│   │   │   └── target.mmi
│   │   ├── pseudo_cellranger
│   │   │   ├── fasta
│   │   │   │   ├── genome.fa
│   │   │   │   └── genome.fa.fai
│   │   │   └── genes
│   │   │       └── genes.gtf
│   │   ├── raw
│   │   │   ├── annotations.gtf
│   │   │   ├── annotations.gtf.gz
│   │   │   ├── cdna.fa.gz
│   │   │   ├── cds.fa.gz
│   │   │   ├── genome.fa
│   │   │   ├── genome.fa.gz
│   │   │   ├── metadata.json
│   │   │   ├── metadata.log
│   │   │   ├── ncrna.fa.gz
│   │   │   └── pep.fa.gz
│   │   └── STAR
│   │       ├── chrLength.txt
│   │       ├── chrNameLength.txt
│   │       ├── chrName.txt
│   │       ├── chrStart.txt
│   │       ├── exonGeTrInfo.tab
│   │       ├── exonInfo.tab
│   │       ├── geneInfo.tab
│   │       ├── Genome
│   │       ├── genomeParameters.txt
│   │       ├── Log.out
│   │       ├── SA
│   │       ├── SAindex
│   │       ├── sjdbInfo.txt
│   │       ├── sjdbList.fromGTF.out.tab
│   │       ├── sjdbList.out.tab
│   │       └── transcriptInfo.tab
│   ├── logs
│   │   └── metadata.log
│   └── rRNA
│       ├── bwa_mem2
│       │   ├── genome.fa.gz
│       │   ├── genome.fa.gz.0123
│       │   ├── genome.fa.gz.amb
│       │   ├── genome.fa.gz.ann
│       │   ├── genome.fa.gz.bwt.2bit.64
│       │   ├── genome.fa.gz.pac
│       │   ├── index.log
│       │   └── ncrna.fa.gz
│       ├── raw
│       │   ├── annotations.gtf
│       │   ├── annotations.gtf.gz
│       │   ├── genome.fa
│       │   └── genome.fa.gz
│       └── STAR
│           ├── chrLength.txt
│           ├── chrNameLength.txt
│           ├── chrName.txt
│           ├── chrStart.txt
│           ├── exonGeTrInfo.tab
│           ├── exonInfo.tab
│           ├── geneInfo.tab
│           ├── Genome
│           ├── genomeParameters.txt
│           ├── Log.out
│           ├── SA
│           ├── SAindex
│           ├── sjdbInfo.txt
│           ├── sjdbList.fromGTF.out.tab
│           ├── sjdbList.out.tab
│           └── transcriptInfo.tab
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