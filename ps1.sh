#!/bin/bash

__pe_ps1_bg () {
	if [ "$1" = "NONE" ]; then
		echo -e ""
	else
		echo -e "\x01\e[48;5;${1}m\x02"
	fi
}

__pe_ps1_fg () {
	if [ "$1" = "NONE" ]; then
		echo -e ""
	else
		echo -e "\x01\e[38;5;${1}m\x02"
	fi
}

__pe_ps1_bold() {
	echo -e "\x01\e[1m\x02"
}

__pe_ps1_reset() {
	echo -e "\x01\e(B\e[m\x02"
}

__pe_ps1() {
	PS1_COLOR_1=234
	if [ "$EUID" -ne 0 ]; then
		PS1_COLOR_2=33
	else
		PS1_COLOR_2=196
	fi
	PS1_COLOR_3=236
	PS1_COLOR_4=248
	PS1_COLOR_TEXT=231
	
	PS1_BOLD=$(__pe_ps1_bold)
	PS1_RESET_COLOR=$(__pe_ps1_reset)
	PS1_SEP_CHAR=$'\uE0B0'
	
	PS1_TIME="${PS1_BOLD}$(__pe_ps1_fg $PS1_COLOR_TEXT)$(__pe_ps1_bg $PS1_COLOR_1)[\t]${PS1_RESET_COLOR}"
	PS1_SEP_1="${PS1_BOLD}$(__pe_ps1_fg $PS1_COLOR_1)$(__pe_ps1_bg $PS1_COLOR_2)${PS1_SEP_CHAR}${PS1_RESET_COLOR}"
	
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		PS1_USER="${PS1_BOLD}$(__pe_ps1_fg $PS1_COLOR_TEXT)$(__pe_ps1_bg $PS1_COLOR_2) \u@\H ${PS1_RESET_COLOR}"
	else
		PS1_USER="${PS1_BOLD}$(__pe_ps1_fg $PS1_COLOR_TEXT)$(__pe_ps1_bg $PS1_COLOR_2) \u ${PS1_RESET_COLOR}"
	fi
	PS1_SEP_2="${PS1_BOLD}$(__pe_ps1_fg $PS1_COLOR_2)$(__pe_ps1_bg $PS1_COLOR_3)${PS1_SEP_CHAR}${PS1_RESET_COLOR}"
	
	PS1_DIR="${PS1_BOLD}$(__pe_ps1_fg $PS1_COLOR_TEXT)$(__pe_ps1_bg $PS1_COLOR_3) \w ${PS1_RESET_COLOR}"

	if git --version &>/dev/null; then
		source /etc/bash_completion.d/git-prompt
	
		PS1_GIT_TEXT=$(__git_ps1)
		if [ "$PS1_GIT_TEXT" = "" ]; then
			PS1_SEP_3="${PS1_BOLD}$(__pe_ps1_fg $PS1_COLOR_3)${PS1_SEP_CHAR}${PS1_RESET_COLOR}"
			PS1_GIT=""
		else
			PS1_SEP_3="${PS1_BOLD}$(__pe_ps1_fg $PS1_COLOR_3)$(__pe_ps1_bg $PS1_COLOR_4)${PS1_SEP_CHAR}${PS1_RESET_COLOR}"
			PS1_GIT="${PS1_BOLD}$(__pe_ps1_fg $PS1_COLOR_TEXT)$(__pe_ps1_bg $PS1_COLOR_4)\$(__git_ps1)${PS1_RESET_COLOR}${PS1_BOLD}$(__pe_ps1_fg $PS1_COLOR_4)${PS1_SEP_CHAR}${PS1_RESET_COLOR}"
		fi
	else
		PS1_SEP_3="${PS1_BOLD}$(__pe_ps1_fg $PS1_COLOR_3)${PS1_SEP_CHAR}${PS1_RESET_COLOR}"
		PS1_GIT=""
	fi

	PS1="${PS1_TIME}${PS1_SEP_1}${PS1_USER}${PS1_SEP_2}${PS1_DIR}${PS1_SEP_3}${PS1_GIT}\n\$${PS1_RESET_COLOR} "
}

PROMPT_COMMAND="__pe_ps1"
