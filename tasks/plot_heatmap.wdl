version 1.0

task plot_heatmap {
  input {
    File identity_matrix
    File script = "plot_identity_heatmap.py"
  }

  command <<<
    pip install --no-cache-dir pandas matplotlib seaborn
    python3 ~{script} ~{identity_matrix} heatmap.png
  >>>

  output {
    File heatmap = "heatmap.png"
  }

  runtime {
    docker: "python:3.11-slim"
    memory: "2G"
    cpu: 1
  }
}