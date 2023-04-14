FROM archlinux

# Install git and any other dependencies you may need
RUN pacman -Syu --noconfirm git vim npm gcc tmux

# Set the working directory for the Docker container
WORKDIR /root/

# Clone your Git repository
RUN git clone -b implement_coc https://github.com/ccolorado/configfiles ~/configfiles

# Set the command to run when the Docker container starts
# CMD [ "bash ./configfiles/bin/binder" ]
# CMD [ "bash ./configfiles/bin/devenv" ]

# BUILD; docker build --no-cache -t config:coc .
# RUN; docker run -it --rm --name config_container config:coc
# single line ; docker build --no-cache -t config:coc . ; docker run -it --rm --name config_container config:coc
