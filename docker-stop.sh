#!/bin/bash

echo "🛑 停止 Java Question Community 微服务项目 (Docker 模式)"

# 检查 Docker 是否运行
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker 未运行"
    exit 1
fi

echo "⏹️  停止所有服务..."
docker-compose down

echo "🧹 清理未使用的容器和镜像..."
docker system prune -f

echo "📊 清理后的容器状态："
docker ps -a

echo ""
echo "✅ 所有服务已停止！"
echo "💡 使用 './docker-start.sh' 重新启动所有服务" 