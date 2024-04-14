# Sentiment-Analysis-ML-Project

### Methodology

This project's workflow is based on the Gitflow methodology, except it only uses the main, dev, and feature branches.

### Docker

docker build . -t news-analyser

docker run -p 8888:8888 -v <path> --name news-analyser -u 0 --rm news-analyser
