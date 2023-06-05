FROM debian:bullseye-slim
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y wget unzip openjdk-17-jre && \
	useradd -m ghidra
# /repositories should be a volume accessible to ghidra.
WORKDIR /home/ghidra
USER ghidra
RUN wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.3_build/ghidra_10.3_PUBLIC_20230510.zip && \
	unzip ghidra_10.3_PUBLIC_20230510.zip && \
	mv ghidra_10.3_PUBLIC ghidra && \
	sed -i "s/ghidra\.repositories\.dir=\.\/repositories/ghidra.repositories.dir=\/repositories/" ./ghidra/server/server.conf && \
	sed -i "s/wrapper.app.parameter.2=\${ghidra.repositories.dir}//" ./ghidra/server/server.conf && \
	echo "wrapper.app.parameter.2=-ip\nwrapper.app.parameter.3=<DOMAIN-OR-IP-HERE>\nwrapper.app.parameter.4=\${ghidra.repositories.dir}" >> ./ghidra/server/server.conf
CMD ["/home/ghidra/ghidra/server/ghidraSvr", "console"]
