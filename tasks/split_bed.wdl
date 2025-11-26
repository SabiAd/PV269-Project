version 1.0

task split_bed {
  input {
    File bed_file
  }

  command <<<
    set -euo pipefail
    
    touch p_arm_telomeric.bed q_arm_telomeric.bed
    
    awk 'BEGIN{OFS="\t"} \
          {if(!($1 in s)){s[$1]=$2; e[$1]=$3; print $1"\t"$2"\t"$3 >> "p_arm_telomeric.bed"} \
           else{print $1"\t"$2"\t"$3 >> "q_arm_telomeric.bed"}}' ~{bed_file}
  >>>

  output {
    File start_bed = "p_arm_telomeric.bed"
    File end_bed   = "q_arm_telomeric.bed"
  }

  runtime {
    docker: "debian:stable-slim"
    docker_entrypoint: "/bin/sh"
    cpu: 1
    memory: "1GB"
  }
}
