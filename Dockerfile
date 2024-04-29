FROM mambaorg/micromamba

# install PDM
# RUN pip install -U pdm
# disable update check
# ENV PDM_CHECK_UPDATE=false
# install dependencies and project into the local packages directory
# RUN pdm install --check --no-editable
# # copy files
# COPY pyproject.toml pdm.lock README.md requirements.txt /NewsAnalyser/
WORKDIR /NewsAnalyser

COPY requirements.txt ./
RUN micromamba create -n NewsAnalyser python=3.11 -f requirements.txt -c conda-forge -y

ENTRYPOINT [ "micromamba", "run", "-n", "NewsAnalyser", "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root"]
# command to build: docker build . -t news-analyser
# command to run with shell: docker run -it --entrypoint /bin/bash -p 8888:8888 -v C:\Place\Your\Path\project\Sentiment-Analysis-ML-Project\src:/NewsAnalyser/src --rm news-analyser
# command to run without shell: docker run -p 8888:8888 -v C:\Users\pafin\ML\project\Sentiment-Analysis-ML-Project\src:/NewsAnalyser/src --name test-notebook --rm news-analyser
