RELEASE=${1:-33}
REGISTRY=${2:-"129.104.6.165:32219"}
IMAGE="phare/teamcity-fedora"
FULL_NAME="${REGISTRY}/${IMAGE}:${RELEASE}"
docker build --build-arg RELEASE=$RELEASE -t ${FULL_NAME} .
