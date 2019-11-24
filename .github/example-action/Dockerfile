FROM debian:10.1

LABEL "version"="0.0.5"
LABEL "com.github.actions.name"="Example Actions"
LABEL "com.github.actions.description"="Test Bed for random actions"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/realwear/WN-SDK-TEMPORARY/"
LABEL "maintainer"="MikeHamilton-RW"

RUN apt update \
	&& apt -y upgrade \
	&& apt install -y hub \
	&& apt autoremove \
	&& apt autoclean \
	&& apt clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
