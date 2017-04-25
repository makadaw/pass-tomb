#!/usr/bin/env bash
# Tomb manager - Password Store Extension (https://www.passwordstore.org/)
# Copyright (C) 2017 Alexandre PUJOL <alexandre@pujol.io>.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# This file should be sourced by all test-scripts
#
# This scripts sets the following:
#   $PASS	Full path to password-store script to test
#   $GPG	Name of gpg executable
#   $KEY{1..5}	GPG key ids of testing keys
#   $TEST_HOME	This folder
#

# shellcheck disable=SC1091

#
# Check dependencies
#

PASS="$(which pass)"
if [[ ! -e "$PASS" ]]; then
	echo "Could not find pass command"
	exit 1
fi

TOMB="$(which tomb)"
if [[ ! -e "$TOMB" ]]; then
	echo "Could not find tomb command"
	exit 1
fi

GPG="$(which gpg)"
if [[ ! -e "$GPG" ]]; then
	if which gpg2 &>/dev/null; then
		GPG="gpg2"
	else
		echo "Could not find gpg command"
		exit 1
	fi
fi

COVERAGE="false"
if [[ "$COVERAGE" == "true" ]]; then
	exit 1
else
	_pass() { "$PASS" "${@}"; }
fi


#
# sharness config
#
TEST_HOME="$(pwd)"
EXT_HOME="$(dirname "$TEST_HOME")"
source ./sharness.sh
export SHARNESS_TRASH_DIRECTORY="/tmp/pass-tomb"
mkdir -p "$SHARNESS_TRASH_DIRECTORY"


#
#  Prepare pass config vars
#
unset PASSWORD_STORE_DIR
unset PASSWORD_STORE_KEY
unset PASSWORD_STORE_GIT
unset PASSWORD_STORE_GPG_OPTS
unset PASSWORD_STORE_X_SELECTION
unset PASSWORD_STORE_CLIP_TIME
unset PASSWORD_STORE_UMASK
unset PASSWORD_STORE_GENERATED_LENGTH
unset PASSWORD_STORE_CHARACTER_SET
unset PASSWORD_STORE_CHARACTER_SET_NO_SYMBOLS
unset PASSWORD_STORE_ENABLE_EXTENSIONS
unset PASSWORD_STORE_EXTENSIONS_DIR
unset PASSWORD_STORE_SIGNING_KEY
unset PASSWORD_STORE_TOMB
unset PASSWORD_STORE_TOMB_FILE
unset PASSWORD_STORE_TOMB_KEY
unset GNUPGHOME
unset EDITOR

export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export PASSWORD_STORE_EXTENSIONS_DIR="$EXT_HOME"
export PASSWORD_STORE_TOMB="$TOMB"
export GIT_DIR="$PASSWORD_STORE_DIR/.git"
export GIT_WORK_TREE="$PASSWORD_STORE_DIR"
git config --local user.email "Pass-Automated-Testing-Suite@zx2c4.com"
git config --local user.name "Pass Automated Testing Suite"


#
# GnuPG config
#
unset GPG_AGENT_INFO
export GNUPGHOME="$TEST_HOME/gnupg/"
export KEY1="D4C78DB7920E1E27F5416B81CC9DB947CF90C77B"
export KEY2="70BD448330ACF0653645B8F2B4DDBFF0D774A374"
export KEY3="62EBE74BE834C2EC71E6414595C4B715EB7D54A8"
export KEY4="9378267629F989A0E96677B7976DD3D6E4691410"
export KEY5="4D2AFBDE67C60F5999D143AFA6E073D439E5020C"
chmod 700 "$GNUPGHOME"


#
# Test helpers
#

test_pass_populate() {
	local path=""
	[[ -z "$1" ]] || path="$1/"
	"$PASS" generate "${path}Tests/user1"
	"$PASS" generate "${path}Tests/user2"
}

test_cleanup() {
	"$TOMB" slam all &> /dev/null
	sudo rm -rf "$SHARNESS_TRASH_DIRECTORY"
	mkdir -p "$SHARNESS_TRASH_DIRECTORY"
}