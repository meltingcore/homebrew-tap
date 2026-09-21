#!/usr/bin/env bash

set -euo pipefail

if [[ "$#" -lt 2 || "$#" -gt 3 ]]; then
  echo "usage: $0 VERSION MACOS_RELEASE_ZIP [OUTPUT]" >&2
  exit 2
fi

version="$1"
archive="$2"
repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
template="${repository_root}/templates/malina.rb.tmpl"
output="${3:-${repository_root}/Casks/malina.rb}"

if [[ ! "${version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "version must be a stable semantic version: ${version}" >&2
  exit 1
fi

expected_archive="malina-${version}-macos-universal.zip"
if [[ ! -f "${archive}" ]]; then
  echo "macOS release archive not found: ${archive}" >&2
  exit 1
fi
if [[ "$(basename "${archive}")" != "${expected_archive}" ]]; then
  echo "expected archive name '${expected_archive}', got '$(basename "${archive}")'" >&2
  exit 1
fi

if command -v sha256sum >/dev/null 2>&1; then
  sha256="$(sha256sum "${archive}" | awk '{print $1}')"
else
  sha256="$(shasum -a 256 "${archive}" | awk '{print $1}')"
fi
if [[ ! "${sha256}" =~ ^[0-9a-f]{64}$ ]]; then
  echo "failed to calculate a valid SHA-256 for ${archive}" >&2
  exit 1
fi

mkdir -p "$(dirname "${output}")"
temporary_output="$(mktemp "${output}.tmp.XXXXXX")"
trap 'rm -f "${temporary_output}"' EXIT

sed \
  -e "s/@@VERSION@@/${version}/g" \
  -e "s/@@SHA256@@/${sha256}/g" \
  "${template}" > "${temporary_output}"
ruby -c "${temporary_output}" >/dev/null
mv "${temporary_output}" "${output}"
trap - EXIT

echo "Updated ${output} for Malina ${version}."
