# keras-doc-pdf
How to generate a PDF with all Keras (Deep Learning framework) documentation ? 

You will find in the **releases** pages different versions of the documentation (2.1.6, 2.1.0, ...)
See: https://github.com/JGuillaumin/keras-doc-pdf/releases

**Note** : the automatic build within the Docker image works only for `2.1.6`, `2.0.0` !!

Version | Release Files | Auto build with Docker
--------| ------------- | ----------------------
`2.1.6` | [Yes](https://github.com/JGuillaumin/keras-doc-pdf/releases/tag/keras-2.1.6)| Yes 
`2.1.5` | No | No
`2.1.4` | No | No
`2.1.3` | No | No
`2.1.2` | No | No
`2.1.1` | No | No
`2.1.0` | No | No
`2.0.0` | [Yes](https://github.com/JGuillaumin/keras-doc-pdf/releases/tag/keras-2.0.0) | Yes
`1.2.0` | No | No
`1.1.0` | No | No

In many versions of Keras, `pandoc` fails to preduce the PDF file !!
Always looking for a bug fix .. (it comes from parsing errors in Latex ...)

## Step by step

#### Dependencies

```bash
sudo apt-get update && apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libpng12-dev \
    libzmq3-dev \
    pkg-config \
    rsync \
    software-properties-common \
    language-pack-de \
    fonts-lmodern \
    lmodern \
    pandoc \
    texlive-base \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-latex-recommended \
    texlive-xetex

# ASCII encoding issue without this line
sudo locale-gen "en_US.UTF-8"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# tensorflow is installed as requirement for keras
pip install tensorflow mkdocs mkdocs-pandoc markdown==2.6.7
```


#### Build the Keras documentation

You need to install Keras from the source code (https://github.com/keras-team/keras). 
```bash
git clone https://github.com/keras-team/keras.git
cd keras/
git fetch --all --tags
git checkout 2.1.6
    
# install Keras and generate the documentation
python setup.py install
cd docs/
python autogen.py
    
# convert to 1 large pandoc file, then into a PDF file
mkdocs2pandoc > ~/keras-2.1.6-doc.pd
pandoc --toc --latex-engine=xelatex -f markdown+grid_tables+table_captions -o ~/keras-2.1.6-doc.pdf ~/keras-2.1.6-doc.pd
```

## Using Docker 

All dependencies will be installed in a Docker image. 
You can build the documentation and export it to a PDF file, for any version (_master_ or different _tags_) in two command lines.

You have to specify the Keras version to use: _master_, _2.1.6_, _2.0.0_, ...


```
docker build -f Dockerfile -t keras-doc:latest .

docker run -v "$PWD":/src/:rw keras-doc:latest 2.1.6

# if you want to remove the image
docker rmi -f keras-doc:latest
```

