#!/bin/bash

source ./scripts/log2.sh

docs_dir=$1
nodes_dir=$2
prefixs_dir=$3
comm=$4
file_path=$5

nfiles=$(ls ${docs_dir} | wc -l)

levels=$(log2 nfiles)

echo -e '\nNumber of Data Files: '${nfiles}

if [ $nfiles == 0 ]
then
    echo
    exit 1
fi

echo -e '\nMerkle Tree Number of Levels: '$(($levels+1))'\n'

if [ $comm == 'Add' ] && [ -f ./docu_merkle_tree.txt ]
then
    read -p 'Create or Update New Merkle Tree (update/create): ' input
    echo
    if [ $input == 'update' ]
    then
        /bin/bash ./scripts/update_mtree.sh $docs_dir $nodes_dir $prefixs_dir $nfiles $levels $file_path
        /bin/bash ./scripts/docu_factory.sh $docs_dir $nodes_dir $prefixs_dir $nfiles $levels
        exit 1
    fi
fi

/bin/bash ./scripts/create_mtree.sh $docs_dir $nodes_dir $prefixs_dir $nfiles $levels
/bin/bash ./scripts/docu_factory.sh $docs_dir $nodes_dir $prefixs_dir $nfiles $levels