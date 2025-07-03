#!/bin/bash

echo "🛑 Java Question Community 微服务项目停止器"

echo "⏹️  停止所有 Java 应用服务..."
pkill -f "spring-boot:run"

echo "🐳 停止 Docker 服务..."
docker-compose -f docker-compose-simple.yml down 2>/dev/null
docker-compose down 2>/dev/null

echo "🧹 清理日志文件..."
> logs/discovery-server.log
> logs/config-server.log
> logs/user-service.log
> logs/content-service.log
> logs/notification-service.log
> logs/search-service.log
> logs/api-gateway.log

echo "📊 清理后的进程状态："
ps aux | grep -E "(spring-boot|java)" | grep -v grep

echo "📊 清理后的容器状态："
docker ps -a

echo ""
echo "✅ 所有服务已停止！"
echo "💡 使用 './start-hybrid.sh' 重新启动服务" 