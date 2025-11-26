version 1.0

task mashmap_align {
  input {
    File fasta
    Int threads = 4
  }

  command <<<
    set -euo pipefail
    mashmap -r ~{fasta} -q ~{fasta} -t ~{threads} --perc_identity=70 -o alignment.paf
  >>>

  output {
    File paf = "alignment.paf"
  }

  runtime {
    docker: "njaved/mashmap:latest"
    docker_entrypoint: "/bin/sh"
    memory: "12G"
  }
}
