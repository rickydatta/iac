FROM google/cloud-sdk:latest

COPY service_account_key.json /usr/bin/

ENV GCP_PROJECT=${PROJECT_ID}

RUN apt update && apt upgrade && \
    apt install -y  python3 && \
    apt clean all && \
    python3 -m pip install --upgrade pip --no-cache-dir  && \
    python3 -m pip install --upgrade ansible  --no-cache-dir \
    python3 -m pip install --upgrade requests --no-cache-dir&& \
    python3 -m pip install --upgrade google-auth --no-cache-dir


ENTRYPOINT ANSIBLE_STDOUT_CALLBACK=debug /usr/bin/ansible-playbook ansible_project_setup.yaml
