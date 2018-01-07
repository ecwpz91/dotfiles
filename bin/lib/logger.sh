#!/usr/bin/env bash

function log-abrt() {
 printf "\xE2\x9E\xA1 [%s ABRT] %s\n" "$(date +'%a %b %d %T')" "${1:-}"
}

function log-info() {
 printf "\xE2\x9E\xA1 [%s INFO] %s\n" "$(date +'%a %b %d %T')" "${1:-}"
}

function log-fail() {
 printf "\xe2\x9c\x98 [%s FAIL] %s\n" "$(date +'%a %b %d %T')" "${1:-}"
}

function log-pass() {
 printf "\xE2\x9C\x94 [%s PASS] %s\n" "$(date +'%a %b %d %T')" "${1:-}"
}
