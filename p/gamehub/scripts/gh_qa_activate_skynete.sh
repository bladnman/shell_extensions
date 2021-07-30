#
# NO LONGER USED
# this is the pattern to create a venv using
# current python version and activating it for this shell
#
# Since moving to venv management through pyenv
# this is no longer used for me. Keeping here in case we move
# away from this one day

SKYNETE_CHECKOUT_FOLDER=~/code/p

# move into the place the venv (will) lives
cd $SKYNETE_CHECKOUT_FOLDER

# tell python to use this env/dir as its current env
python3 -m venv Skynete

# run the standard activate script in the env
source ./Skynete/bin/activate

# add our pyenv shims to front again
# since "activate" can mess with PATH
PATH="/Users/mmaher/.pyenv/shims:$PATH"

cd -
