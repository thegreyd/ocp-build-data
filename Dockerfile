# This is a base image for supporting installing & running microshift on top of a bootc image
FROM registry.redhat.io/rhel9/rhel-bootc:9.4-1725286996

# Start Konflux-specific steps
RUN mkdir -p /tmp/yum_temp; mv /etc/yum.repos.d/*.repo /tmp/yum_temp/ || true
COPY .oit/unsigned.repo /etc/yum.repos.d/
ADD https://certs.corp.redhat.com/certs/Current-IT-Root-CAs.pem /tmp
# End Konflux-specific steps
ENV __doozer=update BUILD_RELEASE=202409050953.p0.gc48c8bc.assembly.microshift.el9 BUILD_VERSION=v4.18.0 OS_GIT_MAJOR=4 OS_GIT_MINOR=18 OS_GIT_PATCH=0 OS_GIT_TREE_STATE=clean OS_GIT_VERSION=4.18.0-202409050953.p0.gc48c8bc.assembly.microshift.el9 SOURCE_GIT_TREE_STATE=clean __doozer_group=openshift-4.18 __doozer_key=microshift-bootc-base __doozer_version=v4.18.0 
ENV __doozer=merge OS_GIT_COMMIT=c48c8bc OS_GIT_VERSION=4.18.0-202409050953.p0.gc48c8bc.assembly.microshift.el9-c48c8bc SOURCE_DATE_EPOCH=1725556256 SOURCE_GIT_COMMIT=c48c8bc1f58d54c3ef5387229e509bb905beebdb SOURCE_GIT_TAG=c48c8bc1 SOURCE_GIT_URL=https://github.com/thegreyd/ocp-build-data 

USER root
# workaround for RHEL-39796 
RUN mv /etc/selinux /etc/selinux.tmp && \
    dnf upgrade -y && \
    dnf clean all && \
    mv /etc/selinux.tmp /etc/selinux
USER 1001

# Start Konflux-specific steps
RUN cp /tmp/yum_temp/* /etc/yum.repos.d/ || true
# End Konflux-specific steps

LABEL \
        name="openshift/microshift-bootc-base" \
        com.redhat.component="microshift-bootc-base-container" \
        io.openshift.maintainer.project="OCPBUGS" \
        io.openshift.maintainer.component="Unknown" \
        version="v4.18.0" \
        release="202409050953.p0.gc48c8bc.assembly.microshift.el9" \
        io.openshift.build.commit.id="c48c8bc1f58d54c3ef5387229e509bb905beebdb" \
        io.openshift.build.source-location="https://github.com/thegreyd/ocp-build-data" \
        io.openshift.build.commit.url="https://github.com/thegreyd/ocp-build-data/commit/c48c8bc1f58d54c3ef5387229e509bb905beebdb"

