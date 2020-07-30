export CONDA_PYTHON_EXE=/home/mans_is/.local/apps/miniconda/bin/python
export PATH=/home/mans_is/.local/apps/miniconda/bin:$PATH
jupyter notebook

# https://askubuntu.com/questions/1017284/cant-create-anaconda-shortcut-to-launch-from-desktop-on-ubuntu-17-10

# https://askubuntu.com/questions/848350/how-to-handle-jupyter-notebook-files-in-ubuntu


# https://askubuntu.com/questions/848350/how-to-handle-jupyter-notebook-files-in-ubuntu
# 1. Create a ipynb.xml mime-info file
# 
# <mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
#     <mime-type type="application/x-ipynb+json">
#         <comment>IPython Notebook</comment>
#         <glob pattern="*.ipynb"/> 
#     </mime-type>
# </mime-info>
# 
# Then store the file in ~/.local/share/mime and update the mime database.
# 
# cp ipynb.xml ~/.local/share/mime
# update-mime-database ~/.local/share/mime
# 
# 2. Create a jupyter.desktop file
# 
# Caution: Edit paths to adapt it to your system and habits.
# 
# [Desktop Entry]
# Version=1.0
# Type=Application
# Name=Jupyter
# Icon="$HOME/.icons/jupyter-sq-text.svg"
# Exec=/path/to/jupyter notebook %F
# Path="$HOME/Documents/Notebooks"
# Comment=Jupyter notebook
# MimeType=application/x-ipynb+json;
# Categories=Science;
# Terminal=true
# 
# Then install the desktop file:
# 
# desktop-file-install --dir="$HOME/.local/share/applications"  jupyter.desktop
# 
# 3. Add the jupyter icon
# 
# I chose the svg version from the design repository of jupyter, and installed in ~/.local/share/icons
# 
# wget https://raw.githubusercontent.com/jupyter/design/master/logo/svg/jupyter-sq-text.svg -o $HOME/.local/share/icons/jupyter-sq-text.svg
# 
# Finally, link the mime-type icon to the system:
# 
# sudo ln -s $HOME/.local/share/icons/jupyter-sq-text.svg /usr/share/icons/gnome/scalable/mimetypes/application-x-ipynb+json.svg
# sudo gtk-update-icon-cache /usr/share/icons/gnome/ -f

