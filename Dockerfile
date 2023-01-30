# FROM google/cloud-sdk:latest

# # COPY service_account_key.json /usr/bin/

# ENV GCP_PROJECT=${PROJECT_ID}

# RUN DEBIAN_FRONTEND=noninteractive apt update && \
#     DEBIAN_FRONTEND=noninteractive apt install wget unzip && \
#     TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'` && \
#     wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip && \
#     unzip terraform_${TER_VER}_linux_amd64.zip && \
#     mv terraform /usr/local/bin/ && \
#     DEBIAN_FRONTEND=noninteractive apt install -y  python3 && \
#     pip install --upgrade pip --no-cache-dir  && \
#     pip install --upgrade ansible  --no-cache-dir \
#     pip install --upgrade requests --no-cache-dir&& \
#     pip install --upgrade google-auth --no-cache-dir

# ENTRYPOINT ANSIBLE_STDOUT_CALLBACK=debug ansible-playbook ansible_project_setup.yaml



ARG BASE_IMAGE=alpine:edge
FROM ${BASE_IMAGE}

ARG ANSIBLE_VERSION=2.7.0-r1

ENV GCP_PROJECT=${PROJECT_ID}


#ENV GCP_AUTH_KIND=serviceaccount
#ENV GCP_SERVICE_ACCOUNT_FILE='/usr/bin/ansible_key.json'
#ENV GOOGLE_IMPERSONATE_SERVICE_ACCOUNT="ansible-new-account@abhinav-scrum-project.iam.gserviceaccount.com"
#ENV GCP_SCOPES='https://www.googleapis.com/auth/bigquery,https://www.googleapis.com/auth/devstorage.full_control,https://www.googleapis.com/auth/devstorage.read_write,https://www.googleapis.com/auth/bigquery.insertdata'
#ENV GCP_STATE_BUCKET=${PROJECT_ID}+"-tfstate"

#updated for gcloud CLI dependencies
RUN apk add --update python3 python3-dev py3-pip curl which bash && \
    pip3 install --upgrade requests google-auth &&\
    apk add --update ansible openssh-client && \
    apk add terraform --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community && \
rm -rf /var/cache/apk/*

# add gcloud CLI
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin
RUN gcloud components install alpha beta
ENV ANSIBLE_STDOUT_CALLBACK=debug

# temporary
#RUN python3 bsc_file_read_and_write.py

# temporary
#ENTRYPOINT ["/usr/bin/ansible-playbook"]

#ENTRYPOINT ANSIBLE_STDOUT_CALLBACK=debug ansible-playbook ansible_project_setup.yaml