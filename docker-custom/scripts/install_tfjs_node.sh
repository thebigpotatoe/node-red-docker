#!/bin/bash
echo "Installing tfjs-node depending on architecture"

# Change into the tfjs-node module folder
cd /usr/src/node-red/node_modules/@tensorflow/tfjs-node/deps || exit 1

# Get the arch of the system to check what to install
arch_name=$(dpkg --print-architecture)
case $arch_name in
"amd64")
    # Do nothing as the correct binaries are installed
    echo "AMD64 arch detected, not installing anything..."
    exit 0
    ;;
"arm64")
    echo "ARM64 arch detected, installing correct binaries..."
    curl -L https://github.com/thebigpotatoe/node-red-contrib-face-recognition/releases/download/v2.0.2/libtensorflow.tar.gz >libtensorflow.tar.gz
    tar -xf libtensorflow.tar.gz && rm libtensorflow.tar.gz
    ;;
"armf")
    echo "ARM32 arch detected, installing correct binaries..."
    # curl -L https://github.com/thebigpotatoe/node-red-contrib-face-recognition/releases/download/v2.0.2/libtensorflow.tar.gz >libtensorflow.tar.gz
    # tar -xf libtensorflow.tar.gz && rm libtensorflow.tar.gz
    ;;
*)
    >&2 echo "Unsupported architecture detected, stopping build!"
    exit 0
    ;;
esac

# Rebuild the tfjs-node module from scratch
cd /usr/src/node-red
npm rebuild @tensorflow/tfjs-node --build-from-source

# Debug out
echo "Done"