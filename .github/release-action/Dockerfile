FROM debian:10.1

LABEL "repository"="https://github.com/realwear/WN-SDK-TEMPORARY/"
LABEL "maintainer"="MikeHamilton-RW"

RUN apt update \
	&& apt -y upgrade \
	&& apt install -y hub \
	&& apt install -y curl \
	&& apt install -y jq \
	&& apt autoremove \
	&& apt autoclean \
	&& apt clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
