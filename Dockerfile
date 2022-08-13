FROM summerwind/actions-runner

RUN sudo apt-get -y update && \
    sudo apt-get -y install fuse-overlayfs git uidmap libcap2-bin && \
    sudo rm -rf /var/cache/apt/* /var/lib/apt/lists/* /var/log/*

RUN sudo setcap cap_setuid+ep /usr/bin/newuidmap && \
    sudo setcap cap_setgid+ep /usr/bin/newgidmap && \
    sudo chmod u-s,g-s /usr/bin/newuidmap /usr/bin/newgidmap

ENV WERF_CONTAINERIZED=yes
ENV WERF_BUILDAH_MODE=auto

