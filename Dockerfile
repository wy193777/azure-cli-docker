FROM docker:stable

RUN apk update \
    && apk add bash \
    && apk add --virtual=build gcc libffi-dev musl-dev openssl openssl-dev curl python3 python3-dev make \
    && pip3 install --upgrade pip setuptools \
    && pip3 install cffi azure-cli \
    && if [[ ! -e /usr/bin/python ]]; \
        then ln -sf /usr/bin/python3 /usr/bin/python; \
    fi

RUN az --version
RUN az aks install-cli
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh
RUN pip install docker-compose
COPY ./run_test.sh ./
