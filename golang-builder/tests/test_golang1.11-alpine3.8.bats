#!/usr/bin/env bats
setup() {
    docker pull "ghcr.io/atsu/golang-builder:go1.11-alpine3.8" >&2
}

@test "alpine version is correct" {
  run docker run "ghcr.io/atsu/golang-builder:go1.11-alpine3.8" cat /etc/os-release
  [ $status -eq 0 ]
  [ "${lines[2]}" = "VERSION_ID=3.8.1" ]
}

@test "go version is correct" {
  run docker run "ghcr.io/atsu/golang-builder:go1.11-alpine3.8" go version
  [ $status -eq 0 ]
  [ "$output" = "go version go1.11.1 linux/amd64" ]
}
