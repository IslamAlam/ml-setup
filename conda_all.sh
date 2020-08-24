#!/bin/bash


NB_USER=$USER
CONDA_DIR=$ROOT_DIR/conda
BASE_DIR=$ROOT_DIR/

# Install Tini
conda install --quiet --yes 'tini=0.18.0' && \
    conda list tini | grep tini | tr -s ' ' | cut -d ' ' -f 1,2 >> $CONDA_DIR/conda-meta/pinned && \
    conda clean --all -f -y

# Install Jupyter Notebook, Lab, and Hub
# Generate a notebook server config
# Cleanup temporary files
# Correct permissions
# Do all this in a single RUN command to avoid duplicating all of the
# files across image layers when the permissions change
conda install --quiet --yes \
    'notebook=6.0.3' \
    'jupyterhub=1.1.0' \
    'jupyterlab=2.1.5' \
    'nodejs=12.*' \
    'zsh' && \
    conda clean --all -f -y && \
    npm cache clean --force && \
    # jupyter notebook --generate-config && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn

# ################ scipy-notebook
# Install Python 3 packages
# numba update to 0.49 fails resolving deps.
conda install --quiet --yes \
    'beautifulsoup4=4.9.*' \
    'conda-forge::blas=*=openblas' \
    'bokeh=2.0.*' \
    'bottleneck=1.3.*' \
    'cloudpickle=1.4.*' \
    'cython=0.29.*' \
    'dask=2.15.*' \
    'dill=0.3.*' \
    'h5py=2.10.*' \
    'hdf5=1.10.*' \
    'ipywidgets=7.5.*' \
    'ipympl=0.5.*'\
    'matplotlib-base=3.2.*' \
    'numba=0.48.*' \
    'numexpr=2.7.*' \
    'pandas=1.0.*' \
    'patsy=0.5.*' \
    'protobuf=3.11.*' \
    'pytables=3.6.*' \
    'scikit-image=0.16.*' \
    'scikit-learn=0.23.*' \
    'scipy=1.4.*' \
    'seaborn=0.10.*' \
    'sqlalchemy=1.3.*' \
    'statsmodels=0.11.*' \
    'sympy=1.5.*' \
    'vincent=0.4.*' \
    'widgetsnbextension=3.5.*'\
    'xlrd=1.2.*'
    conda clean --all -f -y
    pip install --upgrade jupyterlab-git
    # Install Debugger in Jupyter Lab
    pip install --no-cache-dir xeus-python
    jupyter labextension install @jupyterlab/debugger --no-build
    # Activate ipywidgets extension in the environment that runs the notebook server
    jupyter nbextension enable --py widgetsnbextension --sys-prefix 
    # Also activate ipywidgets extension for JupyterLab
    # Check this URL for most recent compatibilities
    # https://github.com/jupyter-widgets/ipywidgets/tree/master/packages/jupyterlab-manager
    jupyter labextension install @jupyter-widgets/jupyterlab-manager@^2.0.0 --no-build
    jupyter labextension install @bokeh/jupyter_bokeh@^2.0.0 --no-build
    jupyter labextension install jupyter-matplotlib@^0.7.2 --no-build
    jupyter labextension install @jupyterlab/toc --no-build
    jupyter labextension install jupyterlab_tensorboard --no-build
    # jupyterlab-gitplus
    pip install --upgrade jupyterlab_gitplus
    jupyter labextension install @reviewnb/jupyterlab_gitplus --no-build
    jupyter serverextension enable --py jupyterlab_gitplus
    # Perspective
    pip install --no-cache-dir pyarrow==0.15.1
    pip install --no-cache-dir perspective-python
    jupyter labextension install @finos/perspective-jupyterlab --no-build
    # nbdime Jupyter Notebook Diff and Merge tools
    pip install --no-cache-dir nbdime
    # jupyterlab_spellchecker
    jupyter labextension install @ijmbarr/jupyterlab_spellchecker --no-build
    # A JupyterLab extension for standalone integration of drawio / mxgraph into jupyterlab.
    jupyter labextension install jupyterlab-drawio --no-build
    # jupyterlab-toc A Table of Contents extension for JupyterLab.
    jupyter labextension install @jupyterlab/toc --no-build
    # Collapsible_Headings
    jupyter labextension install @aquirdturtle/collapsible_headings --no-build
    # Go to definition extension for JupyterLab
    jupyter labextension install @krassowski/jupyterlab_go_to_definition --no-build   # JuupyterLab 2.x
    # Jupyterlab Code Formatter 
    jupyter labextension install @ryantam626/jupyterlab_code_formatter --no-build
    pip install --upgrade --no-cache-dir jupyterlab_code_formatter black yapf autopep8 isort
    jupyter serverextension enable --py jupyterlab_code_formatter
    # install jupyterlab git
    jupyter labextension install @jupyterlab/git --no-build
    pip install --upgrade --no-cache-dir jupyterlab-git
    jupyter serverextension enable --py jupyterlab_git
    # jupyterlab_voyager
    # A JupyterLab MIME renderer extension to view CSV and JSON data in Voyager 2.
    # jupyter labextension install jupyterlab_voyager --no-build
    # For Matplotlib: https://github.com/matplotlib/jupyter-matplotlib
    jupyter labextension install jupyter-matplotlib --no-build
    # ipyleaflet
    pip install --upgrade --no-cache-dir ipyleaflet
    jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet --no-build
    #
    pip install --upgrade --no-cache-dir ipympl
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
    jupyter lab build -y
    jupyter lab clean -y 
    npm cache clean --force
    rm -rf "/home/${NB_USER}/.cache/yarn" && \
    rm -rf "/home/${NB_USER}/.node-gyp"


# Install facets which does not have a pip or conda package at the moment
cd /tmp
git clone https://github.com/PAIR-code/facets.git && \
    jupyter nbextension install facets/facets-dist/ --sys-prefix && \
    rm -rf /tmp/facets

# Import matplotlib the first time to build the font cache.
# ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

python -c "import matplotlib.pyplot"



conda install -c conda-forge jupyter_contrib_nbextensions


# install Julia packages in /opt/julia instead of $HOME
JULIA_DEPOT_PATH=$ROOT_DIR/julia
JULIA_PKGDIR=$ROOT_DIR/julia
JULIA_VERSION=1.4.1

cd /tmp

# hadolint ignore=SC2046
mkdir "${JULIA_DEPOT_PATH}-${JULIA_VERSION}" && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/$(echo "${JULIA_VERSION}" | cut -d. -f 1,2)"/julia-${JULIA_VERSION}-linux-x86_64.tar.gz" && \
    echo "fd6d8cadaed678174c3caefb92207a3b0e8da9f926af6703fb4d1e4e4f50610a *julia-${JULIA_VERSION}-linux-x86_64.tar.gz" | sha256sum -c - && \
    tar xzf "julia-${JULIA_VERSION}-linux-x86_64.tar.gz" -C "${JULIA_DEPOT_PATH}-${JULIA_VERSION}" --strip-components=1 && \
    rm "/tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz"
ln -fs ${JULIA_DEPOT_PATH}-*/bin/julia $HOME/.local/bin

# Show Julia where conda libraries are \
# mkdir /etc/julia && \
#     echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /etc/julia/juliarc.jl && \
#     # Create JULIA_PKGDIR \
#     mkdir "${JULIA_PKGDIR}" && \
#     chown "${USER}" "${JULIA_PKGDIR}" && \


# R packages including IRKernel which gets installed globally.
conda install --quiet --yes \
    'r-base=3.6.3' \
    'r-caret=6.0*' \
    'r-crayon=1.3*' \
    'r-devtools=2.3*' \
    'r-forecast=8.12*' \
    'r-hexbin=1.28*' \
    'r-htmltools=0.4*' \
    'r-htmlwidgets=1.5*' \
    'r-irkernel=1.1*' \
    'r-nycflights13=1.0*' \
    'r-plyr=1.8*' \
    'r-randomforest=4.6*' \
    'r-rcurl=1.98*' \
    'r-reshape2=1.4*' \
    'r-rmarkdown=2.1*' \
    'r-rsqlite=2.2*' \
    'r-shiny=1.4*' \
    'r-tidyverse=1.3*' \
    'rpy2=3.1*' \
    && \
    conda clean --all -f -y

# Add Julia packages. Only add HDF5 if this is not a test-only build since
# it takes roughly half the entire build time of all of the images on Travis
# to add this one package and often causes Travis to timeout.
#
# Install IJulia as jovyan and then move the kernelspec out
# to the system share location. Avoids problems with runtime UID change not
# taking effect properly on the .local folder in the jovyan home dir.
julia -e 'import Pkg; Pkg.update()' && \
    (test $TEST_ONLY_BUILD || julia -e 'import Pkg; Pkg.add("HDF5")') && \
    julia -e "using Pkg; pkg\"add IJulia\"; pkg\"precompile\"" && \
    # move kernelspec out of home \
    mv "${HOME}/.local/share/jupyter/kernels/julia"* "${CONDA_DIR}/share/jupyter/kernels/" && \
    chmod -R go+rx "${CONDA_DIR}/share/jupyter"


# ######### Jupyter Notebook Data Science Stack
# hadolint ignore=SC2046



# Add Julia packages. Only add HDF5 if this is not a test-only build since
# it takes roughly half the entire build time of all of the images on Travis
# to add this one package and often causes Travis to timeout.
#
# Install IJulia as jovyan and then move the kernelspec out
# to the system share location. Avoids problems with runtime UID change not
# taking effect properly on the .local folder in the jovyan home dir.


# Install Tensorflow
pip install --quiet --no-cache-dir \
    'tensorflow==2.2.0'