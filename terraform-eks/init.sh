test -z $ENVIRONMENT_NAME && echo "exit, ENVIRONMENT_NAME empty" && exit 1

cat remote_state.TEMPLATE|sed s/%%ENVIRONMENT_NAME%%/$ENVIRONMENT_NAME/ > remote_state_$ENVIRONMENT_NAME.tf

