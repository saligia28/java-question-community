#!/bin/bash

# 初始化SDKMAN
source "$HOME/.sdkman/bin/sdkman-init.sh"

echo "🚀 启动Java问答社区微服务项目..."

# 检查Java版本
echo "📋 检查Java版本..."
java -version

# 检查Maven版本
echo "📋 检查Maven版本..."
mvn -version

echo ""
echo "🔧 开始启动服务..."

# 启动服务发现中心
echo "1️⃣ 启动服务发现中心 (Eureka Server)..."
cd discovery-server
mvn spring-boot:run > ../logs/discovery-server.log 2>&1 &
DISCOVERY_PID=$!
cd ..

# 等待服务发现中心启动
echo "⏳ 等待服务发现中心启动..."
sleep 10

# 启动配置中心
echo "2️⃣ 启动配置中心 (Config Server)..."
cd config-server
mvn spring-boot:run > ../logs/config-server.log 2>&1 &
CONFIG_PID=$!
cd ..

# 等待配置中心启动
echo "⏳ 等待配置中心启动..."
sleep 10

# 启动用户服务
echo "3️⃣ 启动用户服务..."
cd user-service
mvn spring-boot:run > ../logs/user-service.log 2>&1 &
USER_PID=$!
cd ..

# 启动内容服务
echo "4️⃣ 启动内容服务..."
cd content-service
mvn spring-boot:run > ../logs/content-service.log 2>&1 &
CONTENT_PID=$!
cd ..

# 启动通知服务
echo "5️⃣ 启动通知服务..."
cd notification-service
mvn spring-boot:run > ../logs/notification-service.log 2>&1 &
NOTIFICATION_PID=$!
cd ..

# 启动搜索服务
echo "6️⃣ 启动搜索服务..."
cd search-service
mvn spring-boot:run > ../logs/search-service.log 2>&1 &
SEARCH_PID=$!
cd ..

# 等待业务服务启动
echo "⏳ 等待业务服务启动..."
sleep 15

# 启动API网关
echo "7️⃣ 启动API网关..."
cd api-gateway
mvn spring-boot:run > ../logs/api-gateway.log 2>&1 &
GATEWAY_PID=$!
cd ..

# 保存进程ID
echo $DISCOVERY_PID > logs/discovery-server.pid
echo $CONFIG_PID > logs/config-server.pid
echo $USER_PID > logs/user-service.pid
echo $CONTENT_PID > logs/content-service.pid
echo $NOTIFICATION_PID > logs/notification-service.pid
echo $SEARCH_PID > logs/search-service.pid
echo $GATEWAY_PID > logs/api-gateway.pid

echo ""
echo "✅ 所有服务启动完成！"
echo ""
echo "📊 服务访问地址："
echo "   🔍 服务发现中心: http://localhost:8761"
echo "   ⚙️  配置中心: http://localhost:8888"
echo "   🌐 API网关: http://localhost:8080"
echo "   👤 用户服务: http://localhost:8081"
echo "   📝 内容服务: http://localhost:8082"
echo "   🔔 通知服务: http://localhost:8083"
echo "   🔍 搜索服务: http://localhost:8084"
echo ""
echo "📋 查看日志: tail -f logs/*.log"
echo "�� 停止服务: ./stop.sh" 