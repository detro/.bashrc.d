THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"

# Common utilities
case "${OSTYPE}" in
  solaris*) OSNAME="SOLARIS" ;;
  darwin*)  OSNAME="MACOSX" ;;
  linux*)   OSNAME="LINUX" ;;
  bsd*)     OSNAME="BSD" ;;
  msys*)    OSNAME="WINDOWS" ;;
  *)        OSNAME="${OSTYPE}" ;;
esac

# Source all the 'bashrc.d' files
for BASHRC_D_FILE in `ls ${THIS_DIR}/*.sh`; do
    source $BASHRC_D_FILE
done