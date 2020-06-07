#!/bin/sh

# Decrypt the file
mkdir $HOME/secrets
gpg --quiet --batch --yes --decrypt --passphrase="$GCP_CREDENTIALS_PASSWORD" \
--output $HOME/secrets/service-account-key.json service-account-key.json.gpg