#!/usr/bin/env bats
setup() {
    docker pull "atsuio/golang-builder:go1.8-alpine3.6" >&2
}

@test "alpine version is correct" {
  run docker run "atsuio/golang-builder:go1.8-alpine3.6" cat /etc/os-release
  [ $status -eq 0 ]
  [ "${lines[2]}" = "VERSION_ID=3.6.2" ]
}

@test "go version is correct" {
  run docker run "atsuio/golang-builder:go1.8-alpine3.6" go version
  [ $status -eq 0 ]
  [ "$output" = "go version go1.8.4 linux/amd64" ]
}