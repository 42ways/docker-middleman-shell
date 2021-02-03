# docker-middleman-shell
Middleman (https://middlemanapp.com) build environment

The aim of this project is to provide a docker container with all tools needed to build our website via Middleman.
Therefore no local installation of middleman and it's dependencies is neccessary.

## usage
The script `middleman-shell` contains the startup command for the middleman shell and mounts the current dir
to /middleman. You get a bash in the container, where you can run your Middleman commands.
