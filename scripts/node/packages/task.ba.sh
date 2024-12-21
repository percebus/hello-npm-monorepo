# !/bin/bash

set -e
set -v

cmd=${1}

if [ -z ${cmd} ]; then
  cmd="test"
fi

# TODO for each package
npm run sub:express-app:${cmd}
npm run sub:rest-app:${cmd}
npm run sub:package-c:${cmd}

set +v
set +e
