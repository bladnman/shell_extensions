##
##  NOTE:
##  NAMES WILL COLLIDE WITH OTHER SCRIPTS
##  take care to add this project's name to the
##  end of everything. SelectAll/Replace makes
##  it easy.
##


# -=-+-=-+-=-+-=-+
# -= ENV VARS
# -=-+-=-+-=-+-=-+
SCRIPT_DIR_PYTHON_SPARK=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
SCRIPT_FULL_PATH_PYTHON_SPARK="$SCRIPT_DIR_PYTHON_SPARK/$(basename -- "$0")"


# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  VARS
# -=-=-=-=-=-=-=-=-=-=-=-=
CODE_FOLDER_PYTHON_SPARK=~/code/python/python_spark
CODE_FOLDER_EC2=$CODE_FOLDER_PYTHON_SPARK/ec2
EC2_INSTANCE_DNS="ec2-18-118-35-218.us-east-2.compute.amazonaws.com"


# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  ALIASES
# -=-=-=-=-=-=-=-=-=-=-=-=
alias cdec2spark='cd $CODE_FOLDER_PYTHON_SPARK'
alias py_spark_conn_ec2='ssh -i $CODE_FOLDER_EC2/ec2_spark.pem ubuntu@$EC2_INSTANCE_DNS'


# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  FUNCTIONS
# -=-=-=-=-=-=-=-=-=-=-=-=


# -=-=-=-=-=-=-=-=-=-=-=-=
# -=  MAIN
# -=-=-=-=-=-=-=-=-=-=-=-=
