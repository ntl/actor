#!/usr/bin/env bash

set -eEuo pipefail

trap 'printf "\n\e[31mError: Exit Status %s (%s)\e[m\n" $? "$(basename "$0")"' ERR

cd "$(dirname "$0")"

echo
echo "Start ($(basename "$0"))"

echo
echo "Publish"
echo "= = ="

gem_version=$(ruby -rrubygems -e 'puts Gem::Specification.load("actor.gemspec").version.to_s')
echo "Gem Version: $gem_version"
echo

echo "Running tests"
echo "- - -"

gems/exec/bench

echo
echo "Tag Release"
echo "- - -"
git tag -a "v$gem_version" -m "Version $gem_version" &&
  git push origin "v$gem_version"

echo
echo "Publishing to rubygems.org"
echo "- - -"

gem build *.gemspec
gem push ntl-actor-$gem_version.gem || true

rm -vf *.gem

echo
echo "Done ($(basename "$0"))"
