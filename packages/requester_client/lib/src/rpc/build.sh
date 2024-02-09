cd $(dirname "$0")
protoc --dart_out=. -I. common/common.proto
protoc --dart_out=grpc:. -I. \
  client/client_service.proto \
  log/log_service.proto
git add -A