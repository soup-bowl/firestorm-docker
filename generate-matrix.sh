#!/usr/bin/env bash
set -Eeuo pipefail

# Prints the CI build matrix (versions and their image tags) derived from versions.json.
# The newest version gets "edge", and the newest version of each major gets the major tag.

cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

jq -c '
	to_entries
	| sort_by(.key | split(".") | map(tonumber)) | reverse
	| . as $all
	| map(
		(.key | split(".")[0]) as $major
		| {
			version: .key,
			fullVersion: .value.version,
			tags: (
				[ .value.version, .key ]
				+ (if ([ $all[] | select(.key | split(".")[0] == $major) ][0].key == .key) then [ $major ] else [] end)
				+ (if $all[0].key == .key then [ "edge" ] else [] end)
			)
		}
	)
	| { include: . }
' versions.json
