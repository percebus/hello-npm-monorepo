# !/bin/bash

set -e

cmd=${1}
if [ -z ${cmd} ]; then
  cmd="test"
fi

set -x

# TODO for each package
npm run sub:express-app:${cmd}
npm run sub:rest-app:${cmd}
npm run sub:package-c:${cmd}

set +x
set +e
