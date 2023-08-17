FROM docker:dind-rootless

RUN apk update
RUN apk upgrade
RUN apk add bash
RUN apk add --virtual=build gcc libffi-dev musl-dev openssl openssl-dev curl python3 python3-dev make
RUN apk add py3-pip
RUN pip install --upgrade pip setuptools
RUN pip install cffi azure-cli
RUN if [[ ! -e /usr/bin/python ]]; \
        then ln -sf /usr/bin/python3 /usr/bin/python; \
    fi

RUN az --version
RUN az aks install-cli
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh
COPY ./run_test.sh ./
