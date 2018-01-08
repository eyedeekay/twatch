FROM debian:sid
RUN apt-get update
RUN apt-get install -y checkinstall make
COPY . /home/twatch
WORKDIR /home/twatch
CMD checkinstall --default \
    --install=no \
    --pkgname=twatch \
    --pkgversion=0.1 \
    --pkgsource=http://github.com/eyedeekay/twatch \
    --maintainer=problemsolver@openmailbox.org \
    --nodoc --deldoc=yes --deldesc=yes --delspec=yes --backup=no
