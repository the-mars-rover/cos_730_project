#!/bin/sh

# Decrypt the file
mkdir $HOME/secrets
gpg --quiet --batch --yes --decrypt --passphrase="$GCP_CREDENTIALS_PASSWORD" \
--output invite_only_core/service-account-key.json .github/encrypted/service-account-key.json.gpg