# docker-compiler-explorer with Fortran support

This Dockerfile will build/pull a rather large image/container, using our additions for Fortran support to run [Matt Godbolt's Compiler Explorer](https://github.com/mattgodbolt/compiler-explorer) with Fortran enabled. While Fortran support is there, syntax highlighting can still be improved and doesn't catch all Fortran styles.

Run the usual `docker build .` to create the image (approx. 5GB in size), then `docker run -p 10240:10240 <image>` to access it via `http://localhost:10240`.

The Readme.md from the original repo read:

# docker-compiler-explorer

A docker-based version of [Matt Godbolt's Compiler Explorer](https://github.com/mattgodbolt/compiler-explorer) for self-hosting purposes.

The repository contains a `Dockerfile` with all the required instructions to build the compiler explorer application (with some adjustments to the Makefile as long as there's no 'sudo') and a `docker-compose.yml` file, which keeps some setup instructions such as the port mapping and network, in case you might want to map the default port exposed by the application, 10240, in an easy way.

## Requirements

* Docker (possibly the latest version, 17.06+)
* docker-compose (1.16+)

## Build/Run instructions

You can just type in your terminal:

`docker pull madduci/docker-compiler-explorer:latest && docker-compose up -d`

to use my docker image or, in case of adjustments to the `Dockerfile`, just type:

`docker-compose up -d` 

and you're done. On the first time, it will build the image based on the modified `Dockerfile`.

Once launched, you can just point your browser to http://localhost:10240 (or to the port you've defined in the `docker-compose.yml` file)
