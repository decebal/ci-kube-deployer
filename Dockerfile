FROM lachlanevenson/k8s-kubectl

# make sure the package repository is up to date
RUN apk update \
 && apk upgrade \
 && apk add bash git yarn curl ssh \
 && rm -rf /var/cache/*/* \
 && echo "" > /root/.ash_history

# change default shell from ash to bash
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

RUN yarn global add lerna

RUN \
	apk -Uuv add make gcc groff less \
		musl-dev libffi-dev openssl-dev \
		python2-dev py-pip && \
	pip install awscli docker-compose && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

ENV LC_ALL=en_US.UTF-8
