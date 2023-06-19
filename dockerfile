FROM archlinux

# Install git and any other dependencies you may need
RUN pacman -Suy --noconfirm
RUN pacman -S --noconfirm sudo git
RUN pacman -S --noconfirm vim tmux
RUN pacman -S --noconfirm npm yarn
RUN pacman -S --noconfirm gcc python-pipenv
# RUN pip3 install ecdsa fastecdsa sympy cairo-lang

ARG USERNAME=ccolorado
ARG USER_UID=1000
ARG USER_HOME=/home/${USERNAME}
ARG USER_GROUP=wheel

# Create new user with specified UID and home directory
RUN useradd --uid ${USER_UID} --home ${USER_HOME} --create-home ${USERNAME}

# Add user to specified groups
RUN usermod -aG ${USERNAME} ${USERNAME}
RUN usermod -aG ${USER_GROUP} ${USERNAME}

# Set ownership and permissions for user's home directory
RUN chown -R ${USERNAME}:${USERNAME} ${USER_HOME}
RUN chmod 700 ${USER_HOME}

RUN echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USERNAME}

USER ${USERNAME}

WORKDIR ${USER_HOME}

RUN rm ${USER_HOME}/.bashrc
RUN rm ${USER_HOME}/.bash_profile

RUN git clone https://github.com/ccolorado/configfiles.git "${USER_HOME}/_git.configfiles"
