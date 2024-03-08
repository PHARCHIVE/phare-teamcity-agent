ARG RELEASE=37
FROM fedora:$RELEASE

WORKDIR /root
COPY run.sh /root
RUN chmod +x run.sh && ./run.sh
