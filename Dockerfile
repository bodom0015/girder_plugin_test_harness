FROM python:3.6

# Install CMake
RUN apt-get -qq update && \
    apt-get -qq install cmake && \
    apt-get -y clean all && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN git clone https://github.com/whole-tale/girder /girder
WORKDIR /girder
RUN pip install -r requirements-dev.txt --no-cache-dir && \
    pip install flake8 coverage --no-cache-dir

VOLUME /girder/plugins/wholetale

ENV PYTHON="/usr/local/bin/python3" \
    COVERAGE="/usr/local/bin/coverage" \
    FLAKE8="/usr/local/bin/flake8"

COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "" ]

RUN git clone https://github.com/whole-tale/girder_wt_data_manager /girder/plugins/wt_data_manager && \
    pip install -r plugins/wt_data_manager/requirements.txt && \
    git clone https://github.com/whole-tale/globus_handler /girder/plugins/globus_handler && \
    pip install -r plugins/globus_handler/requirements.txt
