#!/bin/bash

echo "🚀 启动 Java Question Community 微服务项目 (Docker 模式)"

# 检查 Docker 是否运行
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker 未运行，请先启动 Docker Desktop"
    exit 1
fi

# 检查 docker-compose 是否可用
if ! command -v docker-compose &> /dev/null; then
    echo "❌ docker-compose 命令不可用，请确保已安装 Docker Compose"
    exit 1
fi

echo "📦 构建并启动所有服务..."
docker-compose up -d --build

echo "⏳ 等待服务启动..."
sleep 10

echo "🔍 检查服务状态..."
docker-compose ps

echo "📊 服务访问地址："
echo "   🌐 API 网关: http://localhost:8080"
echo "   🔍 服务发现: http://localhost:8761"
echo "   ⚙️  配置中心: http://localhost:8888"
echo "   👤 用户服务: http://localhost:8081"
echo "   📝 内容服务: http://localhost:8082"
echo "   🔔 通知服务: http://localhost:8083"
echo "   🔎 搜索服务: http://localhost:8084"
echo "   🗄️  MySQL: localhost:3306"
echo "   🚀 Redis: localhost:6379"

echo ""
echo "✅ 所有服务已启动！"
echo "💡 使用 'docker-compose logs -f' 查看实时日志"
echo "💡 使用 './docker-stop.sh' 停止所有服务" 