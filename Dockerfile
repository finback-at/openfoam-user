FROM finback9/openfoam-base:0.1

ARG Uid=1000
ARG Gid=1000
RUN groupadd --gid $Gid developer && \
    useradd --uid $Uid --gid $Gid --create-home --shell /usr/bin/bash developer

RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8 \
    TZ=JST-9

USER developer
WORKDIR /home/developer
RUN echo "#!/usr/bin/bash" > start.sh && \
    echo "source /usr/lib/openfoam/openfoam2506/etc/bashrc" >> start.sh && \
    echo "jupyter lab --no-browser --ip=0.0.0.0 --port=8888 --NotebookApp.token=''" >> start.sh && \
    chmod +x start.sh && \
    echo "source /usr/lib/openfoam/openfoam2506/etc/bashrc" >> .bashrc
RUN pip install xlsxwriter line_profiler ply
ENV PATH=${PATH}:/home/developer/.local/bin
WORKDIR /home/developer/workspace    
CMD /home/developer/start.sh
