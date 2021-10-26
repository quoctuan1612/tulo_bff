#!/bin/sh

if [ $# -lt 1 ]; then
  cat <<_EOT_
Please specify the service name
ex.
docker-compose run --rm app sh scripts/proto_converter.sh crm
make update-pb SERVICE=campaigns
_EOT_
  exit 1
else
  rm -rf app/rpc_stubs/tulo/$1
  mkdir app/rpc_stubs/tulo/$1
  find tulo_grpc/proto/tulo/$1 -name "*.proto" | xargs grpc_tools_ruby_protoc -I ./tulo_grpc/proto --ruby_out=./app/rpc_stubs --grpc_out=./app/rpc_stubs
fi
