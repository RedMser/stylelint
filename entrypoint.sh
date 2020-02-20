#!/bin/sh

set -e

configPath="./"
indentSpaces=2
pattern="*.css"

if [ ! -z "${CONFIG_PATH}" ]; then
  configPath=$CONFIG_PATH
fi
if [ ! -z "${INDENT_SPACES}" ]; then
  indentSpaces=$INDENT_SPACES
fi
if [ ! -z "${PATTERN}" ]; then
  pattern=$PATTERN
fi

stylelint_path="node_modules/.bin/stylelint"
if [ ! -e stylelint_path ]; then
  echo "${stylelint_path} not found, add via yarn"
  yarn add stylelint stylelint-config-standard --silent
fi

if [ ! "$(echo ${configPath}.stylelintrc*)" != "${configPath}.stylelintrc*" ]; then
  echo "${configPath}.stylelintrc* not found, generating default"
  echo "{
  \"extends\": \"stylelint-config-standard\",
  \"rules\": {
    \"indentation\": $indentSpaces
  }
}" > .stylelintrc
fi

echo ::add-path::${stylelint_path}

sh -c "$stylelint_path $pattern"
