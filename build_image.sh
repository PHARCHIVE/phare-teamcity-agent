IMAGE="129.104.6.165:32219/phare/teamcity-fc32"
docker build -t ${IMAGE} .
docker run -d=true -e SERVER_URL=https://hephaistos.lpp.polytechnique.fr/teamcity --name=teamcity-docker-minimal-agent -it ${IMAGE} &
sleep 300
docker stop teamcity-docker-minimal-agent
docker commit teamcity-docker-minimal-agent ${IMAGE}
docker rm teamcity-docker-minimal-agent
