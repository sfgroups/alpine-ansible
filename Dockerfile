FROM alpine:3.8

RUN	apk --update add \
		bash \
		ca-certificates \
		git \
		less \
		openssl \
		openssh-client \
		p7zip \
		python \
		py-lxml \
		py-pip \		
    	&& apk --update add --virtual \
		build-dependencies \
		python-dev \
		libffi-dev \
		openssl-dev \
		build-base \
	&& pip install --upgrade \
		pip \		
	&& pip install \
		ansible>=2.6.4 \		
		docker-py \
		dopy  \
		pywinrm  \
		pyvmomi \
		pysphere \
		openshift \
		dictdiffer \
		jinja2 \
		kubernetes \
		python-string-utils \
		ruamel.yaml \
		six \
	&& apk del build-dependencies \
	&& rm -rf /var/cache/apk/*

RUN	mkdir -p /etc/ansible \		
	&& echo 'localhost' > /etc/ansible/hosts \		
	&& mkdir -p ~/.ssh && touch ~/.ssh/known_hosts

ONBUILD	WORKDIR	/tmp
ONBUILD	COPY 	. /tmp
ONBUILD	RUN	ansible -c local -m setup all > /dev/null
CMD ["bash"]


