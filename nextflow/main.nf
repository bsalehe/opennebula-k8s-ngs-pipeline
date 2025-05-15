process KRAKEN2 {
    input:
    path sample

    output:
    path "*.report"

    container 'biocontainers/kraken2:v2.1.1_cv1'

    script:
    """
    kraken2 --db /path/to/kraken2-db --report \${sample.simpleName}.report \${sample}
    """
}

workflow {
    Channel.fromPath("/mnt/data/*.fastq")
        .set { reads }

    KRAKEN2(reads)
}
