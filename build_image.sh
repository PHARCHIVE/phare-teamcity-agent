docker build -t phare/teamcity-fc31 .
docker run -d=true -e SERVER_URL=https://hephaistos.lpp.polytechnique.fr/teamcity --name=teamcity-docker-minimal-agent -it phare/teamcity-fc31 &
sleep 300
docker stop teamcity-docker-minimal-agent
docker commit teamcity-docker-minimal-agent phare/teamcity-fc31
docker rm teamcity-docker-minimal-agent