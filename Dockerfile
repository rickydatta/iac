FROM google/cloud-sdk:latest

ENV DEBIAN_FRONTEND=noninteractive

ENV BUILD_PACKAGES \
  curl \
  python3 \
  python3-dev \
  py3-pip

COPY service_account_key.json /usr/bin/

ENV GCP_PROJECT=${PROJECT_ID}

RUN apk update && apk upgrade && \
    apk add --update --no-cache ${BUILD_PACKAGES} && \
    pip install --upgrade pip && \
    pip install requests && \
    pip install google-auth && \
	apk add --update ansible && \
    # gcloud components install alpha --quiet \
    # gcloud components install beta --quiet \
    # gcloud components update --quiet\
    rm -rf /var/cache/apk/*

ENTRYPOINT ANSIBLE_STDOUT_CALLBACK=debug /usr/bin/ansible-playbook ansible_project_setup.yaml
