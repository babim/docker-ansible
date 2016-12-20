# pull base image
FROM babim/alpinebase

RUN echo "===> Installing sudo to emulate normal OS behavior..."  && \
    apk add --no-cache sudo                                         && \
    \
    \
    echo "===> Adding Python runtime..."  && \
    apk add --no-cache python py-pip openssl ca-certificates    && \
    apk add --no-cache --virtual build-dependencies \
                python-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip cffi                            && \
    \
    \
    echo "===> Installing Ansible..."  && \
    pip install ansible                && \
    \
    \
    echo "===> Installing handy tools (not absolutely required)..."  && \
    apk add --no-cache sshpass openssh-client rsync  && \
    \
    \
    echo "===> Removing package list..."  && \
    apk del build-dependencies            && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo 'localhost' > /etc/ansible/hosts

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["sh"]
