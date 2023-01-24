FROM google/cloud-sdk:latest

# COPY service_account_key.json /usr/bin/

ENV GCP_PROJECT=${PROJECT_ID}

RUN DEBIAN_FRONTEND=noninteractive apt update && \
    DEBIAN_FRONTEND=noninteractive apt install wget unzip && \
    TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'` && \
    wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip && \
    unzip terraform_${TER_VER}_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    DEBIAN_FRONTEND=noninteractive apt install -y  python3 && \
    pip install --upgrade pip --no-cache-dir  && \
    pip install --upgrade ansible  --no-cache-dir \
    pip install --upgrade requests --no-cache-dir&& \
    pip install --upgrade google-auth --no-cache-dir

ENTRYPOINT ANSIBLE_STDOUT_CALLBACK=debug ansible-playbook ansible_project_setup.yaml
