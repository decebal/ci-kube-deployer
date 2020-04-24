FROM lachlanevenson/k8s-kubectl

RUN \
	apk -Uuv add make gcc groff less \
		musl-dev libffi-dev openssl-dev \
		python2-dev py-pip && \
	pip install awscli docker-compose && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

RUN apk update \
 && apk upgrade \
 && apk add bash git yarn curl python3 \
 && rm -rf /var/cache/*/* \
 && echo "" > /root/.ash_history

# change default shell from ash to bash
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

RUN yarn global add lerna

ENV LC_ALL=en_US.UTF-8

RUN ([ -f /usr/bin/sops ] || (wget -q -O /usr/bin/sops https://github.com/mozilla/sops/releases/download/v3.5.0/sops-v3.5.0.linux && chmod +x /usr/bin/sops))

RUN git clone https://github.com/sharkdp/shell-functools /tmp/shell-functools

