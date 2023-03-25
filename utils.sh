#!/bin/bash

function success() {
  echo "$(tput setaf 2)✔︎ ${@}$(tput sgr0)"
}

function err() {
  echo "$(tput setaf 1)${@}$(tput sgr0)"
}

function die() {
  err $@ >&2
  exit 1
}

function has() {
  type "$1" > /dev/null 2>&1
}
