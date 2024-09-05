# This is a base image for supporting installing & running microshift on top of a bootc image
FROM bootc

USER root
RUN dnf upgrade -y  \
 && dnf clean all
USER 1001
