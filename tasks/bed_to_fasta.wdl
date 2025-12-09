version 1.0

task bed_to_fasta {
  input {
    File bed_file
    File fasta_ref
  }

  command <<<
    set -euo pipefail
    awk 'BEGIN{OFS="\t"} {
      start=$2
      end=$3
      if(start>end) {
        tmp=start
        start=end
        end=tmp
      }
      print $1, start, end
    }' ~{bed_file} > normalized.bed
    bedtools getfasta -fi ~{fasta_ref} -bed normalized.bed -fo regions.fa
  >>>

  output {
    File fasta = "regions.fa"
  }

  runtime {
    docker: "danhumassmed/samtools-bedtools:1.0.2"
    docker_entrypoint: "/bin/sh"
    cpu: 1
    memory: "2GB"
  }
}
