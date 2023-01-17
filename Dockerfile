FROM google/cloud-sdk:alpine

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
    rm -rf /var/cache/apk/*


ENTRYPOINT [ "/usr/bin/ansible-playbook" ]
CMD [ "ansible_project_setup.yaml"]