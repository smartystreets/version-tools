FROM smartystreets/version-tools as version-tools

FROM debian:stable
WORKDIR /code
COPY --from=version-tools / /usr/bin
ADD . .
RUN apt-get update && apt-get install -y make zip dpkg-dev debhelper git-core
