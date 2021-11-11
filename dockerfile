FROM httpd:2.4.49
ENV LC_CTYPE=C.UTF-8
RUN apt-get update
RUN apt-get install -y gdb wget git python python3 curl procps gdbserver binutils ltrace
RUN bash -c "$(wget http://gef.blah.cat/sh -O -)"
RUN wget -O ~/.gdbinit-gef.py -q http://gef.blah.cat/py
RUN echo source ~/.gdbinit-gef.py >> ~/.gdbinit

COPY ./gdb_script /tmp/gdb_script
COPY ./httpd.conf /usr/local/apache/conf/httpd.conf

EXPOSE 80
EXPOSE 23456
ENTRYPOINT ["/bin/bash"]
