log_label="unknown"

function log() {
	local command=${1:?}

	if [[ $command == "set" ]]; then

		log_label=${2:?}

	else

		local tag=$command
		local message="$target.$log_label"

		if [[ $command == "task" ]]; then
			echo -e "[$fg_cyan****$fg_reset] $message"
		elif [[ $command == "done" ]]; then
			echo -e "[$fg_green$tag$fg_reset] $message"
		elif [[ $command == "skip" ]]; then
			echo -e "[$fg_yellow$tag$fg_reset] $message"
		else
			echo -e "[$tag] $message"
		fi

	fi
}

fg_reset="\033[0m"
fg_cyan="\033[0;36m"
fg_green="\033[0;32m"
fg_yellow="\033[0;33m"
