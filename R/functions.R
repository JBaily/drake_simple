draw_graph <- function(table, file) {
  pdf(file=file)
  barplot(table$freq, names.arg=table$Length, 
          xlab="Length (cm)", ylab="Frequency", legend.text="Last bar refers 
          to NA--ignore it")
  dev.off()
  
}

plot_tree <- function(tree, file) {
	pdf(file=file)
  plot(tree)
	plot(tree, type = "fan")
	plot(tree, type = "fan", show.tip.label=FALSE, edge.width = 0.1)
	dev.off()
}

print_tree_info <- function(tree) {
  tree_resolution = ape::Nnode(tree)/
    (ape::Ntip(tree)-1)
  text_1 = paste0("The Apogonidae tree has a resolution of ", 
                  tree_resolution, ", where ", ape::Nnode(tree), 
                  " nodes were resolved of ", (ape::Ntip(tree)-1), 
                  " possible nodes.")
  print(text_1)
  struc_file <- file("results/tree_structure_data")
  writeLines(text_1, struc_file)
  close(struc_file)
}

get_study_info <- function(id) {
  study1.metadata <- rotl::get_study_meta(id[1])
  print(rotl::get_publication(study1.metadata))

  text_2 = paste0(rotl::get_publication(study1.metadata))
  struc_file_2 <- file("results/study_info")
  writeLines(text_2, struc_file_2)
  close(struc_file_2)
}

