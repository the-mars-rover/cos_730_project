#!/bin/sh

# This script is used to decrypt the service-account-key for the Google cloud platform service account.
gpg --quiet --batch --yes --decrypt --passphrase="$GCP_CREDENTIALS_PASSWORD" \
--output service-account-key.json scripts/service-account-key.json.gpg