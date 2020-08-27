FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y && apt install -y gr-gsm
RUN apt install -y python-pip wget software-properties-common

RUN  yes | add-apt-repository ppa:wireshark-dev/stable 
RUN apt update -y && apt install -y wireshark 

RUN wget http://git.osmocom.org/gr-gsm/plain/apps/grgsm_livemon.grc &&\
grcc -d . grgsm_livemon.grc && mv grgsm_livemon.py grgsm_livemon 

RUN mv grgsm_livemon /usr/bin/grgsm_livemon

RUN apt install -y gqrx-sdr nano audacity git cmake libbladerf-dev libusb-1.0-0 libusb-1.0-0-dev libxmu-dev
RUN git clone https://github.com/Nuand/bladeRF && cd bladeRF/host && mkdir -p build && cd build &&\
cmake ../ && make && make install && ldconfig
WORKDIR /root
# RUN wget http://www.baudline.com/baudline_1.08_linux_x86_64.tar.gz && tar xzf baudline_1.08_linux_x86_64.tar.gz 
# sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --privileged --rm -it gr-gsm
