#!/bin/bash
set -eu

cd "$(dirname "$0")"

PROFILE=""
STACK_NAME=""

TEMPLATE_FILE="../output/template.yml"

help() {
  echo "need your profile after -p"
  exit 1
}

while getopts p:n:h: OPT
do
  case $OPT in
    p ) PROFILE="$OPTARG" ;;
    n ) STACK_NAME="$OPTARG" ;;
    h ) help ;;  # h: ヘルプを表示
  esac
done

# 削除
echo "----------destroy----------"
yarn cdk destroy ${STACK_NAME} \
    --profile ${PROFILE}
