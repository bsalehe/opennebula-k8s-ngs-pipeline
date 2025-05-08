#!/usr/bin/env nextflow

params.reads = "fastq/*_R{1,2}.fastq.gz"
params.outdir = "results"


process kraken2 {

	input:
	tuple val(sample_id), file(reads)
	
	output:
	file("${sample_id}_report.txt") into results

	container 'biocontainers/kraken2:v2.1.1_cv1'

	script:

	"""

	kraken2 --paired ${reads[0]} ${reads[1]} \
		--db /kraken2-db \
		--report ${sample_id}_report.txt \
		--use-names

	"""

}

Channel
	.fromFilePairs(params.reads, flat: true)
	.map { sample_id, reads -> tuple(sample_id, reads) }
	| kraken2
