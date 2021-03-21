ARG user=docker

FROM ubuntu:latest AS build
ARG user

RUN apt update \
  && apt install --yes p7zip-full wget

RUN useradd -ms /bin/bash ${user}
USER $user
WORKDIR /tmp
# RUN wget https://terraria.org/system/dedicated_servers/archives/000/000/042/original/terraria-server-1412.zip
RUN wget https://www.terraria.org/system/dedicated_servers/archives/000/000/039/original/terraria-server-1405.zip
RUN mkdir extracted \
  && 7z e -aos -oextracted terraria-server*.zip

FROM ubuntu:latest AS run
ARG user

RUN useradd -ms /bin/bash ${user}
USER ${user}
RUN mkdir ~/terraria
WORKDIR /home/${user}/terraria
COPY --from=build /tmp/extracted ./
RUN chmod +x TerrariaServer*

EXPOSE 7777/tcp
ENTRYPOINT ["./TerrariaServer"]
CMD ["-config","config/server.txt"]

