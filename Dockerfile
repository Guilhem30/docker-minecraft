FROM ubuntu:18.04
ENV VERSION 1.11.2.1
ENV LD_LIBRARY_PATH /opt/minecraft
RUN useradd -m game -s /bin/bash -d ${LD_LIBRARY_PATH}
RUN apt-get update && \
	apt-get install -yq unzip curl && \
	curl https://minecraft.azureedge.net/bin-linux/bedrock-server-${VERSION}.zip --output ${LD_LIBRARY_PATH}/bedrock-server.zip && \
	unzip ${LD_LIBRARY_PATH}/bedrock-server.zip -d ${LD_LIBRARY_PATH} && rm ${LD_LIBRARY_PATH}/bedrock-server.zip && \
	chown game:game -R ${LD_LIBRARY_PATH} && \
	apt-get autoremove -yq unzip && \
	apt-get clean


WORKDIR ${LD_LIBRARY_PATH}
USER game


EXPOSE 19132/udp
EXPOSE 19132/tcp

ENTRYPOINT ${LD_LIBRARY_PATH}/bedrock_server


