#!/bin/bash
set -eu

WORKDIR=$(pwd)
cd "$(dirname "$0")"

PROFILE=""
STACK_NAME=""
TEMPLATE_FILE="../output/template.yml"

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
npx cdk synth ${STACK_NAME} > ${TEMPLATE_FILE}
# globalのcdkだとうまくいかない.
# cdk synth > template.yml

# CDKが利用するためのリソースをプロビジョニング
echo "----------bootstarap----------"
npx cdk bootstrap \
    --profile ${PROFILE} \
    --template ${TEMPLATE_FILE}
    # --bootstrap-bucket-name "test" \

# デプロイ
echo "----------deploy----------"
npx cdk deploy ${STACK_NAME} \
    --profile ${PROFILE}
