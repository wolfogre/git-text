#!/usr/bin/env bash

set -ex

source partials/func.sh


is_text "text/plain" || exit 1
is_text "application/csv" || exit 1

is_text "image/png" || exit 0
