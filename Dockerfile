FROM ubuntu:jammy

RUN export DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone;

# Install basic dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends sudo gnupg2 gpg-agent openssh-server openssh-client wget curl ca-certificates git tmux zsh;

# Workaround screeen refresh issues with neovim/ncurses
# Often recommended when using screen/tmux
ENV TERM="screen-256color"
RUN \
  if [ "$UBUNTU_VERSION" = "noble" ]; then \
    apt install --no-install-recommends -y libtinfo6 ncurses-term; \
  else \
    apt install --no-install-recommends -y libtinfo5 ncurses-term; \
  fi


# Create ubuntu user with sudo privileges
RUN useradd -ms /bin/zsh vscode && \
    usermod -aG sudo vscode \
    # New added for disable sudo password
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && echo "User vscode (uid=`id -u vscode`:gid=`id -g vscode`) created with passwordless sudo privileges";

USER vscode
WORKDIR /home/vscode
