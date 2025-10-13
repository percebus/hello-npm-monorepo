# !/bin/bash

set -e

cmd=${1}
if [ -z ${cmd} ]; then
  cmd="test"
fi

set -x

shopt -s nullglob
for dir in ./node/*/; do
  npm --prefix ${dir} run ${cmd}
done

set +x
set +e
