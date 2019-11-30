FROM debian:10.1

LABEL "version"="0.0.5"
LABEL "com.github.actions.name"="APK Publisher"
LABEL "com.github.actions.description"="Build & Publish APK on Github"

LABEL "repository"="https://github.com/realwear/WN-SDK-TEMPORARY/"
LABEL "maintainer"="MikeHamilton-RW"

RUN apt update \
	&& apt -y upgrade \
	&& apt install -y hub \
	&& apt install -y curl \
	&& apt install -y jq=1.6 \
	&& apt autoremove \
	&& apt autoclean \
	&& apt clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
