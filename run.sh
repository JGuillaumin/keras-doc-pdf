#!/bin/bash

. activate keras-doc


if [ $1 == "master" ] || [[ $1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
then
    echo "version : $1"
    pip install tensorflow mkdocs mkdocs-pandoc markdown==2.6.7

    # clone and checkout the correct versison of Keras
    cd /tmp/
    git clone https://github.com/keras-team/keras.git
    cd keras/
    git fetch --all --tags
    git checkout $1
    
    # install Keras and generate the documentation
    python setup.py install
    cd docs/
    python autogen.py
    
    # convert to 1 large pandoc file, then into a PDF file
    mkdocs2pandoc > /src/keras-"$1"-doc.pd
    pandoc --toc --latex-engine=xelatex -f markdown+grid_tables+table_captions -o /src/keras-"$1"-doc.pdf /src/keras-"$1"-doc.pd
else
    echo "will exec $@"
    exec "$@"
fi

