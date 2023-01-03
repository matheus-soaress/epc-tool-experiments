FROM openjdk:8

RUN echo 'alias la="ls -lha"' >> ~/.bashrc

RUN apt-get update && \
        apt-get install -y maven && \
        apt-get install -y build-essential && \
        apt-get install -y time && \
    curl -L https://cpanmin.us | perl - App::cpanminus

WORKDIR /PPgSI

# install defects4j
RUN git clone https://github.com/rjust/defects4j.git
WORKDIR /PPgSI/defects4j
RUN cpanm --installdeps . && \
        ./init.sh
ENV PATH="${PATH}:/PPgSI/defects4j/framework/bin"

WORKDIR /PPgSI

# install ba-control-flow
RUN git clone https://github.com/matheus-soaress/edge-pair-cov-tool.git -b edge-cov-work
WORKDIR /PPgSI/edge-pair-cov-tool
RUN git checkout f30b1eaa4f5315b798cdbbeeab1fce72c5973ae7 && \
        mvn clean install

WORKDIR /PPgSI

# install JaCoCo
RUN git clone https://github.com/jacoco/jacoco.git
WORKDIR /PPgSI/jacoco
RUN git checkout tags/v0.8.8 && \ 
        mvn clean install

WORKDIR /PPgSI

# install epc-tool-experiments
RUN git clone https://github.com/matheus-soaress/epc-tool-experiments.git
WORKDIR /PPgSI/epc-tool-experiments
RUN chmod +x *.sh

WORKDIR /PPgSI
RUN mkdir projects && \
        mkdir reports