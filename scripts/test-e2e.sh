#!/usr/bin/env bash
#
# Copyright 2022 The Dapr Authors
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

echo "Starting Docker"
sudo service docker start

# Start MQTT for Binding tests
# Dashboard: http://localhost:18083 (user: admin, pass: public)
# Ports: 1883 = TCP MQTT Port | 8081 = HTTP API | 8083 = MQTT/SSL Port | 8883 = MQTT/Websocket/SSL Port | 8084 = MQTT/Websocket Port | 18083 = Dashboard
echo "Starting MQTT Broker for specific Bindings"
docker run -d --rm --name emqx -p 1883:1883 -p 8081:8081 -p 8083:8083 -p 8883:8883 -p 8084:8084 -p 18083:18083 emqx/emqx

# Start gRPC tests
echo "Running gRPC tests"
npm run test:e2e:grpc:main

# Start HTTP tests
echo "Running HTTP tests"
npm run test:e2e:http:main
npm run test:e2e:http:actors