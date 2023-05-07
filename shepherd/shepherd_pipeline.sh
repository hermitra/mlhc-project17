## Make changes to project_config.py through setting MY_TEST_DATA

## Run script to get MY_SPL_INDEX_DATA
python /home/lucytian/SHEPHERD/data_prep/shortest_paths/add_spl_to_patients.py --only_test_data

## Run prediction.py
python ~/SHEPHERD/shepherd/predict.py --run_type causal_gene_discovery --patient_data my_data --edgelist KG_edgelist_mask.txt --node_map KG_node_map.txt --saved_node_embeddings_path checkpoints/pretrain.ckpt --best_ckpt checkpoints/causal_gene_discovery.ckpt