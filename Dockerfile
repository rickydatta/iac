FROM google/cloud-sdk:latest

# COPY service_account_key.json /usr/bin/

ENV GCP_PROJECT=${PROJECT_ID}

RUN DEBIAN_FRONTEND=noninteractive apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y gnupg software-properties-common && \
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list && \
    sudo apt update && sudo apt install terraform && \
    DEBIAN_FRONTEND=noninteractive apt install -y  python3 && \
    pip install --upgrade pip --no-cache-dir  && \
    pip install --upgrade ansible  --no-cache-dir \
    pip install --upgrade requests --no-cache-dir&& \
    pip install --upgrade google-auth --no-cache-dir

ENTRYPOINT ANSIBLE_STDOUT_CALLBACK=debug ansible-playbook -vvv ansible_project_setup.yaml
