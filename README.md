# Node-RED Docker

This is a fork of the official docker repo for node red. [Please see it for more info about node-red in docker](https://github.com/node-red/node-red-docker).

Unfortunatley tfjs-node does not run correctly within an alpine or debian docker image, so a custom ubuntu image needed to be built. The aim is to run tfjs-node correctly across architectures for the facial recognition node within a docker container.

The container is built the same way as the official image with the addition of the facial recogntiion node, allowing for compatibility with data used in other officially built container images. 

The image should run correctly on the following;

- Windows using Docker Desktop (amd64)
- MacOS using Docker Desktop (amd64)
- Linux specifically Ubunutu (amd64)
- Raspberry Pi 4 using Ubuntu (arm64v8)
- ~~Raspberry Pi 4 using Raspbian (arm32v7)~~

## Quick Start

Running the image couldnt be simpler, just use the following command:

``` shell

docker run --rm -p 1880:1880 --name node-red-face-recogbition thebigpotatoe/node-red-face-recognition

```

## Building the image

To build the image from scratch use the following command;

``` shell

docker build -t thebigpotatoe/node-red-face-recognition --file Dockerfile ./docker-custom/

```

## Building libtensorflow binaries from scratch using docker

Additionally if you have an architecture that you would like to build tensorflow on, this repo has a dockerfile which can build and export the binaries from scrtach with no effort. The only downside is time, when buildin gon a Pi it can take over 48 hrs and require swap enabled.

> Required RAM using 1 core (swap included) : 12 Gb


``` shell

docker buildx build --file Dockerfile.tfbuild --output ./output .

```