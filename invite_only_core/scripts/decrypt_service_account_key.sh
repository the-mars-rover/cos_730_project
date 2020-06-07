#!/bin/sh

# This script is used to decrypt the service-account-key for the Google cloud platform service account.
mkdir $HOME/secrets
gpg --quiet --batch --yes --decrypt --passphrase="$GCP_CREDENTIALS_PASSWORD" \
--output service-account-key.json service-account-key.json.gpg