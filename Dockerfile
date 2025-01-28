FROM ubuntu:22.04

RUN apt-get update && apt-get install -y wget gnupg lsb-release
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update && apt-get install -y postgresql-client-17 pv

COPY script.sh ./script.sh
RUN chmod +x ./script.sh

CMD ["bash", "script.sh"]