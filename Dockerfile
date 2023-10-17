# Parent definition: https://github.com/jupyter/docker-stacks/blob/main/scipy-notebook/Dockerfile
FROM jupyter/scipy-notebook:2023-08-19

# Additional packages
RUN pip install langchain
RUN pip install openai

RUN pip install nltk
RUN pip install unstructured
RUN pip install tabulate
RUN pip install pdf2image
RUN pip install chromadb
RUN pip install tiktoken
RUN pip install feast

# Feature store: https://github.com/feast-dev/feast
ARG FEATYRE_REPO_PATH
RUN feast init $FEATYRE_REPO_PATH
RUN cd $FEATYRE_REPO_PATH/feature_repo ; feast apply ; CURRENT_TIME=$(date -u +"%Y-%m-%dT%H:%M:%S") ; feast materialize-incremental $CURRENT_TIME
ENV FEATYRE_REPO_PATH=$FEATYRE_REPO_PATH
