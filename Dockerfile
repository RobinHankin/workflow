FROM rocker/r-ver:latest

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev libssl-dev libxml2-dev \
    ghostscript pandoc wget curl perl xz-utils make \
    && rm -rf /var/lib/apt/lists/*

RUN Rscript -e "install.packages('tinytex'); \
    tinytex::install_tinytex(); \
    tinytex::tlmgr_path('add')"

ENV PATH="${PATH}:/root/.TinyTeX/bin/x86_64-linux"

RUN /root/.TinyTeX/bin/x86_64-linux/tlmgr install \
    subfig wrapfig wrapfig2 caption bbm bbm-macros \
    amsfonts doublestroke wasysym wasy ms yfonts grfext \
    tikz-cd environ etoolbox pgf xcolor

RUN Rscript -e "install.packages(c('rcmdcheck', 'remotes', 'sessioninfo'))"

WORKDIR /workspace
