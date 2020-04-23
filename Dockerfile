FROM archlinux
RUN pacman -Syy archlinux-keyring --noconfirm && pacman -Syu --noconfirm && pacman-db-upgrade && trust extract-compat
RUN echo $'[archlinuxcn] \n\
    SigLevel = Optional TrustAll \n\
    Server = http://repo.archlinuxcn.org/$arch \n\
    ' >> /etc/pacman.conf
RUN pacman -Sy --noconfirm archlinuxcn-keyring
RUN pacman -S --noconfirm yaourt sudo binutils autoconf automake cmake base-devel
RUN useradd yaourt && echo "yaourt ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER yaourt
RUN yaourt -S --noconfirm ocserv
USER root
CMD [ "/usr/sbin/ocserv", "-f" ]
