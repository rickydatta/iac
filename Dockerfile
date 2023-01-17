FROM google/cloud-sdk:latest

COPY service_account_key.json /usr/bin/

ENV GCP_PROJECT=${PROJECT_ID}



RUN DEBIAN_FRONTEND=noninteractive \
    apt update && \
    apt upgrade -yq && \
    apt install -y  python3 && \
    pip install --upgrade pip --no-cache-dir  && \
    pip install --upgrade ansible  --no-cache-dir \
    pip install --upgrade requests --no-cache-dir&& \
    pip install --upgrade google-auth --no-cache-dir

ENTRYPOINT ANSIBLE_STDOUT_CALLBACK=debug /usr/bin/ansible-playbook ansible_project_setup.yaml
