# First, install it following: https://cloud.google.com/sdk/docs/install-sdk.
# After uncompressing the downloaded `.tar.gz`, place it in a location that will become it's "installation path".
# Set the following GCLOUD_INSTALL_PATH to that directory:
GCLOUD_INSTALL_PATH=${HOME}/bin/google-cloud-sdk

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${GCLOUD_INSTALL_PATH}/path.bash.inc" ]; then
	source "${GCLOUD_INSTALL_PATH}/path.bash.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "${GCLOUD_INSTALL_PATH}/completion.bash.inc" ]; then
	source "${GCLOUD_INSTALL_PATH}/completion.bash.inc"
fi