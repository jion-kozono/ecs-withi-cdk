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

while getopts pnh: OPT
do
  case $OPT in
    p ) PROFILE=$OPTARG ;;
    n ) STACK_NAME=$OPTARG ;;
    h ) help ;;  # h: ヘルプを表示
  esac
done

# CloudFormationファイルを出力
echo "----------synthesize----------"
yarn cdk synth ${STACK_NAME}
# globalのcdkだとうまくいかない.
# cdk synth > template.yml

# CDKが利用するためのリソースをプロビジョニング
echo "----------bootstarap----------"
yarn cdk bootstrap \
    --profile ${PROFILE} \
    # --bootstrap-bucket-name "test" \

# デプロイ
echo "----------deploy----------"
yarn cdk deploy ${STACK_NAME} \
    --profile ${PROFILE}
