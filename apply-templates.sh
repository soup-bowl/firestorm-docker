#!/usr/bin/env bash
set -Eeuo pipefail

# Generates <version>/Dockerfile from Dockerfile.template for each entry in versions.json.
# Usage: ./apply-templates.sh [version...]

cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

if [ "$#" -eq 0 ]; then
	mapfile -t versions < <(jq -r 'keys_unsorted[]' versions.json)
	set -- "${versions[@]}"
fi

generated_warning() {
	cat <<-EOH
		#
		# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
		#
		# PLEASE DO NOT EDIT IT DIRECTLY.
		#

	EOH
}

for version; do
	export version
	fullVersion="$(jq -r '.[env.version].version // empty' versions.json)"
	if [ -z "$fullVersion" ]; then
		echo >&2 "error: '$version' not found in versions.json"
		exit 1
	fi

	echo "processing $version ($fullVersion) ..."
	mkdir -p "$version"
	{
		generated_warning
		sed -e "s/%%VERSION%%/$fullVersion/g" Dockerfile.template
	} > "$version/Dockerfile"
done
