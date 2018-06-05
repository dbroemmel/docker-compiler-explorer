FROM madduci/docker-linux-cpp:latest

LABEL maintainer="info@micheleadduci.net"

EXPOSE 10240

RUN echo "*** Installing Compiler Explorer ***" \
    && DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y \
        wget \
        ca-certificates \
        nodejs \
        npm \
        make \
        git \
        gfortran-4.8 \
        gfortran-5 \
        gfortran-6 \
        gfortran-7 \
        gfortran-8 \
    && apt-get autoremove --purge -y \
    && apt-get autoclean -y \
    && rm -rf /var/cache/apt/* /tmp/* \
    && git clone https://github.com/FZJ-JSC/compiler-explorer.git /compiler-explorer \
    && cd /compiler-explorer \
    && echo "Correct Nodejs command for Docker" \
    && sed -i '/node_modules\/bower\/bin\/bower install/c\\t\/usr\/bin\/nodejs .\/node_modules\/bower\/bin\/bower install --allow-root' /compiler-explorer/Makefile \
    && sed -i 's|--exec $(NODE) $(NODE_ARGS) -- ./app.js $(EXTRA_ARGS)||' /compiler-explorer/Makefile \
    && echo "Add Compilers to Compiler-Explorer" \
    && sed -i '/compilers=/c\compilers=\/usr\/bin\/g++-4.9:\/usr\/bin\/g++-5:\/usr\/bin\/g++-6:\/usr\/bin\/g++-7:\/usr\/bin\/g++-8:\/usr\/bin\/clang++-3.8:\/usr\/bin\/clang++-3.9:\/usr\/bin\/clang++-4.0:\/usr\/bin\/clang++-5.0:\/usr\/bin\/clang++-6.0' etc/config/c++.defaults.properties \
    && sed -i '/defaultCompiler=/c\defaultCompiler=\/usr\/bin\/g++-8' etc/config/c++.defaults.properties \
    && sed -i '/compilers=/c\compilers=\/usr\/bin\/gfortran-4.8:\/usr\/bin\/gfortran-5:\/usr\/bin\/gfortran-6:\/usr\/bin\/gfortran-7:\/usr\/bin\/gfortran-8' etc/config/fortran.defaults.properties \
    && sed -i '/defaultCompiler=/c\defaultCompiler=\/usr\/bin\/gfortran' etc/config/fortran.defaults.properties \
    && make

WORKDIR /compiler-explorer

ENTRYPOINT [ "/usr/bin/nodejs", "/compiler-explorer/app.js" ]
