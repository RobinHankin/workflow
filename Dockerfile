FROM rocker/r-ver:latest

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    ghostscript \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

RUN Rscript -e "install.packages('tinytex')" \
    && Rscript -e "tinytex::install_tinytex()"
    
RUN Rscript -e "tinytex::tlmgr_install(c('subfig', 'wrapfig', 'wrapfig2', 'caption', \
    'bbm', 'bbm-macros', 'amsfonts', 'doublestroke', 'wasysym', 'wasy', \
    'ms', 'yfonts', 'grfext', 'tikz-cd', 'environ', 'etoolbox', 'pgf', 'xcolor'))"

# Pre-install R-CMD-check requirements to save time
RUN Rscript -e "install.packages(c('rcmdcheck', 'remotes', 'sessioninfo'))"

WORKDIR /workspace
