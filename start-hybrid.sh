#!/bin/bash

echo "🚀 Java Question Community 微服务项目启动器"
echo "请选择启动模式："
echo "1) 本地开发模式 (推荐) - 使用 Maven 直接启动"
echo "2) Docker 混合模式 - 数据库用 Docker，应用用本地"
echo "3) 完整 Docker 模式 - 所有服务都用 Docker (需要网络稳定)"
echo ""
read -p "请输入选择 (1/2/3): " choice

case $choice in
    1)
        echo "🎯 启动本地开发模式..."
        source "$HOME/.sdkman/bin/sdkman-init.sh"
        ./start.sh
        ;;
    2)
        echo "🐳 启动 Docker 混合模式..."
        echo "📦 启动数据库服务..."
        docker-compose -f docker-compose-simple.yml up -d
        
        echo "⏳ 等待数据库启动..."
        sleep 10
        
        echo "🚀 启动应用服务..."
        source "$HOME/.sdkman/bin/sdkman-init.sh"
        
        # 启动应用服务（不包含数据库相关服务）
        echo "启动 discovery-server..."
        cd discovery-server && mvn spring-boot:run > ../logs/discovery-server.log 2>&1 &
        cd ..
        
        echo "启动 config-server..."
        cd config-server && mvn spring-boot:run > ../logs/config-server.log 2>&1 &
        cd ..
        
        sleep 5
        
        echo "启动 user-service..."
        cd user-service && mvn spring-boot:run > ../logs/user-service.log 2>&1 &
        cd ..
        
        echo "启动 content-service..."
        cd content-service && mvn spring-boot:run > ../logs/content-service.log 2>&1 &
        cd ..
        
        echo "启动 notification-service..."
        cd notification-service && mvn spring-boot:run > ../logs/notification-service.log 2>&1 &
        cd ..
        
        echo "启动 search-service..."
        cd search-service && mvn spring-boot:run > ../logs/search-service.log 2>&1 &
        cd ..
        
        sleep 5
        
        echo "启动 api-gateway..."
        cd api-gateway && mvn spring-boot:run > ../logs/api-gateway.log 2>&1 &
        cd ..
        
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
        ;;
    3)
        echo "🐳 启动完整 Docker 模式..."
        echo "⚠️  注意：这需要稳定的网络连接来下载镜像"
        ./docker-start.sh
        ;;
    *)
        echo "❌ 无效选择，默认使用本地开发模式"
        source "$HOME/.sdkman/bin/sdkman-init.sh"
        ./start.sh
        ;;
esac

echo ""
echo "✅ 启动完成！"
echo "💡 使用 './stop-hybrid.sh' 停止所有服务" 