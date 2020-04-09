#!/usr/bin/env bats
setup() {
    docker pull "atsuio/golang-builder:go1.10-alpine3.8" >&2
}

@test "alpine version is correct" {
  run docker run "atsuio/golang-builder:go1.10-alpine3.8" cat /etc/os-release
  [ $status -eq 0 ]
  [ "${lines[2]}" = "VERSION_ID=3.8.0" ]
}

@test "go version is correct" {
  run docker run "atsuio/golang-builder:go1.10-alpine3.8" go version
  [ $status -eq 0 ]
  [ "$output" = "go version go1.10.3 linux/amd64" ]
}