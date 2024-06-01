#!/bin/bash

listApps() {
	print "$(ls $APP_DIR)"
}

argsHandler() {
	local args
	local i

	args=("$@")
	i=0
	while [ "$i" -lt "${#args[@]}" ]; do
		case "${args[$i]}" in
		--help)
			cat "$HELP_FILE"
			return 1
			;;
		--uninstall-command)
			"$SCRIPT_DIR/uninstall.sh"
			return 1
			;;
		--list)
			listApps
			return 1
			;;
		--remove)
			removeApp "${args[((i+1))]}" "${args[$i]}"
			return 1
			;;
		esac
		((i++))
	done
	return 0
}
