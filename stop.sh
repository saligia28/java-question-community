#!/bin/bash

echo "🛑 停止Java问答社区微服务项目..."

# 创建logs目录
mkdir -p logs

# 停止各个服务
if [ -f logs/discovery-server.pid ]; then
    echo "停止服务发现中心..."
    kill $(cat logs/discovery-server.pid) 2>/dev/null
    rm logs/discovery-server.pid
fi

if [ -f logs/config-server.pid ]; then
    echo "停止配置中心..."
    kill $(cat logs/config-server.pid) 2>/dev/null
    rm logs/config-server.pid
fi

if [ -f logs/user-service.pid ]; then
    echo "停止用户服务..."
    kill $(cat logs/user-service.pid) 2>/dev/null
    rm logs/user-service.pid
fi

if [ -f logs/content-service.pid ]; then
    echo "停止内容服务..."
    kill $(cat logs/content-service.pid) 2>/dev/null
    rm logs/content-service.pid
fi

if [ -f logs/notification-service.pid ]; then
    echo "停止通知服务..."
    kill $(cat logs/notification-service.pid) 2>/dev/null
    rm logs/notification-service.pid
fi

if [ -f logs/search-service.pid ]; then
    echo "停止搜索服务..."
    kill $(cat logs/search-service.pid) 2>/dev/null
    rm logs/search-service.pid
fi

if [ -f logs/api-gateway.pid ]; then
    echo "停止API网关..."
    kill $(cat logs/api-gateway.pid) 2>/dev/null
    rm logs/api-gateway.pid
fi

# 强制停止所有Java进程（可选）
echo "清理残留进程..."
pkill -f "spring-boot:run" 2>/dev/null

# 清空所有日志文件内容，但不删除文件
echo "清空所有日志内容..."
find logs/ -type f -name "*.log" -exec sh -c '> "$1"' _ {} \;

echo "✅ 所有服务已停止！" 