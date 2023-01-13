#!/bin/bash
set -eu

WORKDIR=$(pwd)
cd "$(dirname "$0")"

PROFILE=""
STACK_NAME=""

help() {
  echo "need your profile after -p"
  exit 1
}

while getopts ph: OPT
do
  case $OPT in
    p ) PROFILE=$OPTARG ;;
    h ) help ;;  # h: ヘルプを表示
  esac
done

# CDKがデプロイのために使用するためのS3バケットを用意する
echo "----------bootstarap----------"
yarn cdk bootstrap \
    --profile ${PROFILE} \
    --bootstrap-bucket-name "test" \
