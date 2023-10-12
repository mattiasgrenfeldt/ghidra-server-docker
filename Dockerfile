FROM debian:bullseye-slim
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y wget unzip openjdk-17-jre && \
	useradd -m ghidra
# /repositories should be a volume accessible to ghidra.
WORKDIR /home/ghidra
USER ghidra
RUN wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.4_build/ghidra_10.4_PUBLIC_20230928.zip -O ghidra.zip && \
	unzip ghidra.zip && \
	mv ghidra_10.4_PUBLIC ghidra && \
	sed -i "s/ghidra\.repositories\.dir=\.\/repositories/ghidra.repositories.dir=\/repositories/" ./ghidra/server/server.conf && \
	sed -i "s/wrapper.app.parameter.2=\${ghidra.repositories.dir}//" ./ghidra/server/server.conf && \
	echo "wrapper.app.parameter.2=-ip\nwrapper.app.parameter.3=<DOMAIN-OR-IP-HERE>\nwrapper.app.parameter.4=\${ghidra.repositories.dir}" >> ./ghidra/server/server.conf
CMD ["/home/ghidra/ghidra/server/ghidraSvr", "console"]
