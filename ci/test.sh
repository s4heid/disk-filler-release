#!/usr/bin/env bash

set -eu

. /usr/local/bin/start-bosh
. /tmp/local-bosh/director/env

STEMCELL_SHA1=8d50317da51324b66731814c478f1bd29567c988
STEMCELL_VERSION=1.719

bosh upload-stemcell \
    --name=bosh-warden-boshlite-ubuntu-jammy-go_agent \
    --version="${STEMCELL_VERSION}" \
    --sha1=8d50317da51324b66731814c478f1bd29567c988 \
    "https://storage.googleapis.com/bosh-core-stemcells/${STEMCELL_VERSION}/bosh-stemcell-${STEMCELL_VERSION}-warden-boshlite-ubuntu-jammy-go_agent.tgz"

export BOSH_DEPLOYMENT=disk-filler
export BOSH_NON_INTERACTIVE=true

bosh deploy \
    --ops-file=./manifests/operations/local-ops.yml \
    --var=repo_dir="$PWD" \
    --vars-store=/tmp/deployment-vars.yml \
    ./manifests/disk-filler.yml

set +e
bosh run-errand --keep-alive fill-disk
exit=$?
set -e

bosh ssh -c "sudo grep -r '' /var/vcap/sys/log"

bosh delete-deployment
bosh -n clean-up --all
bosh delete-env "/tmp/local-bosh/director/bosh-director.yml" \
    --vars-store="/tmp/local-bosh/director/creds.yml" \
    --state="/tmp/local-bosh/director/state.json"

echo "$exit"