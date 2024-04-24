# Depends on `google-cloud-sdk`.
#
# See: https://formulae.brew.sh/cask/google-cloud-sdk.
if [[ -d "$(brew --prefix)/share/google-cloud-sdk" ]]; then
	source "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"
fi