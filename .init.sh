THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"

# Source all the 'bashrc.d' files
for BASHRC_D_FILE in `ls ${THIS_DIR}/*.sh`; do
    source $BASHRC_D_FILE
done