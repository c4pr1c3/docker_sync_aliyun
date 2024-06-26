#!/usr/bin/env bash

if [[ -z $BASE_HOST ]];then
    BASE_HOST="registry.cn-hangzhou.aliyuncs.com"
fi

if [[ -z $ACR_NAMESPACE ]];then
    ACR_NAMESPACE="cuc-docker-io"
fi

# 从 images.txt 读取镜像名称和版本
while IFS= read -r line; do
    img_name=$(echo $line | cut -d ':' -f 1)
    # 如果 img_name 包含 / 需要替换为 -
    mirror_img_name=$(echo $img_name | sed 's/\//\-/g')
    img_tag=$(echo $line | cut -d ':' -f 2)
    conf_line="${img_name}:${img_tag}: $BASE_HOST/${ACR_NAMESPACE}/${mirror_img_name}:${img_tag}"
    echo "$conf_line" >> images.yaml
done < "images.txt"


cat <<EOF > auth.yaml
$BASE_HOST/$ACR_NAMESPACE:
  username: "\$ACR_USER"
  password: "\$ACR_PASSWORD"
docker.io:
  username: "\$DOCKER_USERNAME"
  password: "\$DOCKER_PASSWORD"
EOF


