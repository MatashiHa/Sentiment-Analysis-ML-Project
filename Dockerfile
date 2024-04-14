FROM pytorch/pytorch

# install conda
# Install base utilities
RUN apt-get update \
    && apt-get install -y build-essential \
    && apt-get install -y wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

# install PDM
RUN pip install -U pdm
# disable update check
ENV PDM_CHECK_UPDATE=false
# copy files
COPY pyproject.toml pdm.lock README.md requirements.txt /NewsAnalyser/
COPY src/ /NewsAnalyser/src

# install dependencies and project into the local packages directory
WORKDIR /NewsAnalyser
RUN conda create -n project python=3.11 --file requirements.txt -y
RUN pdm install --check --no-editable


ENTRYPOINT [ "conda", "run", "-n", "NewsAnalyser", "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root"]
