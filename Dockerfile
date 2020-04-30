FROM fedora:32
#Derived from official TeamCity image
LABEL modified "philip.deegan <philip.deegan@gmail.com>"

RUN dnf update -y

RUN dnf install -y java-1.8.0-openjdk xorg-x11-server-Xvfb git make cmake tar gzip unzip \
                   zlib-devel.x86_64 gcovr environment-modules wget m4 \
                   openmpi openmpi-devel hdf5 hdf5-devel \
                   hdf5-openmpi-devel python3 sphinx python3-sphinx python3-sphinx_rtd_theme \
                   python3-breathe python3-docutils python3-numpy python3-scipy python3-openmpi \
                   python3-mpi4py-openmpi libasan libubsan lcov python3-ddt \
                   which gitstats wget doxygen g++ clang \
                   python3-h5py python3-matplotlib


VOLUME /data/teamcity_agent/conf
ENV CONFIG_FILE=/data/teamcity_agent/conf/buildAgent.properties \
    TEAMCITY_AGENT_DIST=/opt/buildagent

RUN mkdir $TEAMCITY_AGENT_DIST

ADD https://teamcity.jetbrains.com/update/buildAgent.zip $TEAMCITY_AGENT_DIST/
RUN unzip $TEAMCITY_AGENT_DIST/buildAgent.zip -d $TEAMCITY_AGENT_DIST/

LABEL dockerImage.teamcity.version="latest" \
      dockerImage.teamcity.buildNumber="latest"

COPY run-agent.sh /run-agent.sh
COPY run-services.sh /run-services.sh

RUN useradd -m buildagent && \
    chmod +x /run-agent.sh /run-services.sh && \
    rm $TEAMCITY_AGENT_DIST/buildAgent.zip && \
    sync
#add line return for derived images
RUN echo " " >> /opt/buildagent/conf/buildAgent.dist.properties && \
    echo "system.distrib=fedora" >> /opt/buildagent/conf/buildAgent.dist.properties && \
    echo "system.project=phare" >> /opt/buildagent/conf/buildAgent.dist.properties && \
    echo "system.agent_name=teamcity-docker-phare-fc32" >> /opt/buildagent/conf/buildAgent.dist.properties

CMD ["/run-services.sh"]

EXPOSE 9090
