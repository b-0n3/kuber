FROM debian:buster

COPY ./srcs/HolderSetup.sh ./HolderSetup.sh
RUN chmod +x HolderSetup.sh
RUN /bin/bash HolderSetup.sh
