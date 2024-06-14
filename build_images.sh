#!/usr/bin/env bash
BASE_HOST="registry.cn-beijing.aliyuncs.com"

if [[ -z $ACR_NAMESPACE ]];then
    ACR_NAMESPACE="cuc-docker-io"
fi

# 从 images.txt 读取镜像名称和版本
while IFS= read -r line; do
    img_name=$(echo $line | cut -d ':' -f 1)
    img_tag=$(echo $line | cut -d ':' -f 2)
    conf_line="${img_name}:${img_tag}: $BASE_HOST/${ACR_NAMESPACE}/${img_name}:${img_tag}"
    echo "$conf_line" >> images.yaml
done < "images.txt"




