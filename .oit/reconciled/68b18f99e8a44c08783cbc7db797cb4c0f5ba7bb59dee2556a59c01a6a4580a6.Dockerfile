# This is a base image for supporting installing & running microshift on top of a bootc image
FROM bootc

USER root
# workaround for RHEL-39796 
RUN mv /etc/selinux /etc/selinux.tmp && \
    dnf upgrade -y && \
    dnf clean all && \
    mv /etc/selinux.tmp /etc/selinux
USER 1001
