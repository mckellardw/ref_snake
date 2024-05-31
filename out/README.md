Example file tree for mouse & human:
```
{SPECIES}/
├── genome
│   ├── bwa_mem2
│   │   ├── index.log
│   │   ├── ref.fa.gz
│   │   ├── ref.fa.gz.0123
│   │   ├── ref.fa.gz.amb
│   │   ├── ref.fa.gz.ann
│   │   ├── ref.fa.gz.bwt.2bit.64
│   │   └── ref.fa.gz.pac
│   ├── minimap2
│   │   ├── mm2.log
│   │   └── target.mmi
│   ├── pseudo_cellranger
│   │   ├── fasta
│   │   │   ├── genome.fa
│   │   │   └── genome.fa.fai
│   │   └── genes
│   │       └── genes.gtf
│   └── STAR
│       ├── chrLength.txt
│       ├── chrNameLength.txt
│       ├── chrName.txt
│       ├── chrStart.txt
│       ├── exonGeTrInfo.tab
│       ├── exonInfo.tab
│       ├── geneInfo.tab
│       ├── Genome
│       ├── genomeParameters.txt
│       ├── Log.out
│       ├── SA
│       ├── SAindex
│       ├── sjdbInfo.txt
│       ├── sjdbList.fromGTF.out.tab
│       ├── sjdbList.out.tab
│       └── transcriptInfo.tab
├── logs
│   ├── gene_info.log
│   ├── gff2bed.log
│   └── transcript_info.log
├── plots
│   ├── gene_biotypes_summary.png
│   └── transcript_biotypes_summary.png
├── raw
│   ├── annotations.bed
│   ├── annotations.gtf
│   ├── annotations.gtf.gz
│   ├── cdna.fa.gz
│   ├── cds.fa.gz
│   ├── chrom_sizes.tsv
│   ├── gene_info.tsv
│   ├── genome.fa.fai
│   ├── genome.fa.gz
│   ├── metadata.json
│   ├── metadata.log
│   ├── ncrna.fa.gz
│   ├── pep.fa.gz
│   ├── rRNA.fa.gz
│   ├── transcript_info.tsv
│   └── transcriptome.fa.gz
├── rRNA
│   ├── bwa_mem2
│   │   ├── index.log
│   │   ├── ref.fa.gz
│   │   ├── ref.fa.gz.0123
│   │   ├── ref.fa.gz.amb
│   │   ├── ref.fa.gz.ann
│   │   ├── ref.fa.gz.bwt.2bit.64
│   │   └── ref.fa.gz.pac
│   ├── raw
│   │   ├── annotations.gtf
│   │   ├── annotations.gtf.gz
│   │   ├── ref.fa
│   │   └── ref.fa.gz
│   └── STAR
│       ├── chrLength.txt
│       ├── chrNameLength.txt
│       ├── chrName.txt
│       ├── chrStart.txt
│       ├── exonGeTrInfo.tab
│       ├── exonInfo.tab
│       ├── geneInfo.tab
│       ├── Genome
│       ├── genomeParameters.txt
│       ├── Log.out
│       ├── SA
│       ├── SAindex
│       ├── sjdbInfo.txt
│       ├── sjdbList.fromGTF.out.tab
│       ├── sjdbList.out.tab
│       └── transcriptInfo.tab
└── transcriptome
    ├── bwa_mem2
    │   ├── index.log
    │   ├── ref.fa.gz
    │   ├── ref.fa.gz.0123
    │   ├── ref.fa.gz.amb
    │   ├── ref.fa.gz.ann
    │   ├── ref.fa.gz.bwt.2bit.64
    │   └── ref.fa.gz.pac
    ├── kb
    │   ├── cdna.fa
    │   ├── kb_ref.log
    │   ├── t2g.txt
    │   └── transcriptome.idx
    ├── kb_nuc
    │   ├── cdna.fa
    │   ├── cdna.t2c
    │   ├── intron.fa
    │   ├── intron.t2c
    │   ├── kb_ref.log
    │   ├── t2g.txt
    │   └── transcriptome.idx
    ├── kb_velo
    │   ├── cdna.fa
    │   ├── cdna.t2c
    │   ├── intron.fa
    │   ├── intron.t2c
    │   ├── kb_ref.log
    │   ├── t2g.txt
    │   └── transcriptome.idx
    └── minimap2
        ├── mm2.log
        └── target.mmi
```
