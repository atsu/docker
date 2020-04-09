

This is the base builder for building golang applications against alpine3.8 with go1.11.x with selected libraries

To use this container, simply go into the directory you wish to build (typically a descendent from go path), then 
use docker run, while binding the current go path to the /gopath/ directory inside the container and set the working 
directory to pwd (the directory in which to build) and run your go command.

Optionally, you can bind to the /build directory as well in order to have the build output generated in a specific directory

Usage examples:
docker run -ti -v $GOPATH:/gopath -w $(pwd) go build .
docker run -ti -v /home/user/go:/gopath -w /home/user/go/github.com/user/repo go build .
docker run -ti -v $GOPATH:/gopath -v /some/target:/build -w $(pwd) go build -o /build/target.bin .