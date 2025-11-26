version 1.0

task pad_bed {
  input {
    File bed_file
    Int pad
  }

  command <<<
    set -euo pipefail
    
    awk -v pad=~{pad} 'BEGIN{OFS="\t"} \
    {
      chr=$1
      start=$2
      end=$3
      
      
      if (start <= 1000) {
        new_start = end
        new_end = end + pad
      } 
      
      else {
        raw_start = start - pad
        # Zabrání záporným souřadnicím
        new_start = (raw_start > 0) ? raw_start : 0 
        new_end = start
      }
      
      print chr, new_start, new_end
    }' ~{bed_file} > padded.bed
  >>>

  output {
    File padded = "padded.bed"
  }

  runtime {
    docker: "debian:stable-slim"
    docker_entrypoint: "/bin/sh"
    cpu: 1
    memory: "1GB"
  }
}