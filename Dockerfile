FROM quay.io/buildah/stable

RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc
RUN dnf -y install gcc libffi openssl curl python3 make
RUN pip install --upgrade pip setuptools
RUN dnf install -y https://packages.microsoft.com/config/rhel/9.0/packages-microsoft-prod.rpm
RUN dnf install azure-cli

RUN az --version
RUN az aks install-cli
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh
COPY ./run_test.sh ./
