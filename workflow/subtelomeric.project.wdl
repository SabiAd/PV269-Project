version 1.0

import "../tasks/split_bed.wdl"
import "../tasks/pad_bed.wdl"
import "../tasks/bed_to_fasta.wdl"
import "../tasks/mashmap_align.wdl"
import "../tasks/pairwise_identity.wdl"
import "../tasks/plot_heatmap.wdl"

workflow subtelomeric_project {
  input {
    File bed_file
    Int pad
    File fasta_ref
    Int threads = 4
    File script
  }

  call split_bed.split_bed {
    input: bed_file = bed_file
  }

  call pad_bed.pad_bed as pad_p {
    input:
      bed_file = split_bed.start_bed,
      pad = pad
  }

  call pad_bed.pad_bed as pad_q {
    input:
      bed_file = split_bed.end_bed,
      pad = pad
  }

  call bed_to_fasta.bed_to_fasta as p_fasta {
    input:
      bed_file = pad_p.padded,
      fasta_ref = fasta_ref
  }

  call bed_to_fasta.bed_to_fasta as q_fasta {
    input:
      bed_file = pad_q.padded,
      fasta_ref = fasta_ref
  }

  call mashmap_align.mashmap_align as p_arm_align {
    input:
      fasta = p_fasta.fasta,
      threads = threads
  }

  call mashmap_align.mashmap_align as q_arm_align {
    input:
      fasta = q_fasta.fasta,
      threads = threads
  }

  call pairwise_identity.pairwise_identity as p_arm_identity {
    input:
      paf_file = p_arm_align.paf
  }

  call pairwise_identity.pairwise_identity as q_arm_identity {
    input:
      paf_file = q_arm_align.paf
  }

  call plot_heatmap.plot_heatmap as plot_p_arm {
    input:
      identity_matrix = p_arm_identity.identity_matrix,
      script = script
  }

  call plot_heatmap.plot_heatmap as plot_q_arm {
    input:
      identity_matrix = q_arm_identity.identity_matrix,
      script = script
  }

  output {
    File p_arm_raw = split_bed.start_bed
    File q_arm_raw = split_bed.end_bed
    File p_arm_padded = pad_p.padded
    File q_arm_padded = pad_q.padded
    File p_fasta_file = p_fasta.fasta
    File q_fasta_file = q_fasta.fasta
    File p_arm_paf = p_arm_align.paf
    File q_arm_paf = q_arm_align.paf
    File p_arm_identity_matrix = p_arm_identity.identity_matrix
    File q_arm_identity_matrix = q_arm_identity.identity_matrix
    File p_arm_heatmap = plot_p_arm.heatmap
    File q_arm_heatmap = plot_q_arm.heatmap
  }
}