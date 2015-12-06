FROM debian:jessie

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ENV PATH /opt/conda/bin:$PATH
ENV LANG C.UTF-8
ENV MINICONDA Miniconda3-3.18.3-Linux-x86_64.sh
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/$MINICONDA && \
    bash /$MINICONDA -b -p /opt/conda && \
    rm $MINICONDA && \
    conda install -y conda==3.18.3 && \
    conda update -y conda && \
    conda install -y jupyter && \
    pip install pulp unionfind && \
    rm -rf /opt/conda/pkgs/*
EXPOSE 8888
VOLUME ["/jupyter"]
WORKDIR /jupyter
COPY data /root/tmp/data/
COPY pic /root/tmp/pic/
COPY *.ipynb /root/tmp/
COPY init.sh /root/
CMD ["sh", "/root/init.sh"]
