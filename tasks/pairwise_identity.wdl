version 1.0

task pairwise_identity {
  input {
    File paf_file
  }

  command <<<
    set -euo pipefail

    awk 'BEGIN{OFS="\t"} 
    {
      # $1 = query chrom
      # $6 = target chrom
      # $10 = percent identity
      key = $1"\t"$6"\t"$10
      if(!seen[key]++) {
        print $1, $6, $10
      }
    }' ~{paf_file} > pairwise_identity.txt
  >>>

  output {
    File identity_matrix = "pairwise_identity.txt"
  }

  runtime {
    docker: "debian:stable-slim"
    docker_entrypoint: "/bin/sh"
    cpu: 1
    memory: "2GB"
  }
}