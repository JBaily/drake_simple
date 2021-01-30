plan <- drake_plan(
   #get tree and data from Open Tree of Life
   taxon.names = read.csv(file=file_in("data/taxa.csv")),
   apogonidae.id = rotl::tnrs_match_names(taxon.names[3,1])$ott_id,
   tree = rotl::tol_subtree(ott_id=apogonidae.id, 
                                       label_format = "name"),
   
   print_tree_info(tree),
   tree_print = plot_tree(tree, file=file_out("results/tree.pdf")),
   
   fish.study.trees =  studies_find_trees(property="ot:ottTaxonName", 
                                     value=taxon.names[3,1], 
                                     detailed=FALSE),
   fish.studies.ids = unlist(fish.study.trees$study_ids),
   get_study_info(fish.studies.ids),
   fish.study1.tree1 = get_study(fish.studies.ids[[1]]),
   study_fish = ape::plot.phylo(fish.study1.tree1, type="fan", cex=0.2),
   study_plot_real = plot_tree(fish.study1.tree1, file=file_out("results/
                                                         study_tree")),
   
   #get length data from fishbase.org (github.com/ropensci/rfishbase)
   
   fish = rfishbase::species_list(Family = "Apogonidae"),
   field_wanted = c("Species", "Length", " "),
   fish_table_test = species(species_list = fish),
   
   desired_table = fish_table_test[,c("Species", "Length")],
   write.csv(desired_table,"results/length.csv", row.names = TRUE),
   frequency_length = count(desired_table, "Length"),
   
   write.csv(frequency_length,"results/length_freq.csv", row.names = TRUE),
   fish_graph = draw_graph(frequency_length, 
                           file=file_out("results/data_plot.pdf"))
)