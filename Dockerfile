ARG BASE_IMAGE=alpine:edge
FROM ${BASE_IMAGE}

ARG ANSIBLE_VERSION=2.7.0-r1

# COPY service_account_key.json /usr/bin/

ENV GCP_PROJECT=${PROJECT_ID}
# ENV GCP_AUTH_KIND=serviceaccount
# ENV GCP_SERVICE_ACCOUNT_FILE='/usr/bin/service_account_key.json'
#ENV GCP_SCOPES='https://www.googleapis.com/auth/bigquery,https://www.googleapis.com/auth/devstorage.full_control,https://www.googleapis.com/auth/devstorage.read_write,https://www.googleapis.com/auth/bigquery.insertdata'

RUN apk add --update python3 python3-dev py3-pip && \
		pip3 install --upgrade requests google-auth &&\
		apk add --update ansible openssh-client && \
		apk add terraform --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community && \
    rm -rf /var/cache/apk/*


ENTRYPOINT ["/usr/bin/ansible-playbook"]