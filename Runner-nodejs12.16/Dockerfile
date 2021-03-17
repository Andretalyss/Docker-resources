FROM node:12.16-buster-slim

ARG TINI_VERSION=v0.19.0

#install dependency
RUN apt-get update 
RUN  apt-get install -y curl 
    # install tini
RUN  curl -Lo /usr/local/bin/tini https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-amd64 
RUN  chmod +x /usr/local/bin/tini 
  
  
    # install docker
# - Not agree, docker:dind is available.
#RUN  curl -fsSL https://get.docker.com -o get-docker.sh 
#RUN  sh get-docker.sh
#RUN usermod -aG docker root
#VOLUME /var/run/docker.sock

    # install aws cli
RUN  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
RUN  apt-get -y install unzip 
RUN  unzip awscliv2.zip 
RUN  ./aws/install 

    # install ssh-server
RUN  apt-get install -y openssh-server 
RUN  mkdir -p /var/run/sshd

EXPOSE 22

ARG GITLAB_RUNNER_VERSION=v12.9.0

# install gitlab-runner
RUN curl -Lo /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/${GITLAB_RUNNER_VERSION}/binaries/gitlab-runner-linux-amd64 \
    && chmod +x /usr/local/bin/gitlab-runner && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
    && apt-get -y install git-lfs \
    && git lfs install --skip-repo

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["tini", "--", "/usr/local/bin/docker-entrypoint.sh"]
