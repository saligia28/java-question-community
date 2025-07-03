# Java问答社区微服务项目

## 📋 项目简介

这是一个基于Spring Cloud的微服务架构Java问答社区项目，包含用户管理、内容管理、通知服务、搜索服务等核心功能。

## 🏗️ 架构设计

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   API Gateway   │    │ Discovery Server│    │ Config Server   │
│   (Port: 8080)  │    │   (Port: 8761)  │    │  (Port: 8888)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
         ┌───────────────────────┼───────────────────────┐
         │                       │                       │
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  User Service   │    │ Content Service │    │Notification Svc │
│  (Port: 8081)   │    │  (Port: 8082)   │    │  (Port: 8083)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │  Search Service │
                    │  (Port: 8084)   │
                    └─────────────────┘
```

## 🚀 快速启动

### 方式一：本地开发启动（推荐）

#### 前置条件
- Java 17+
- Maven 3.6+
- Git

#### 启动步骤

1. **克隆项目**
```bash
git clone <repository-url>
cd java-question-community
```

2. **一键启动所有服务**
```bash
./start.sh
```

3. **查看服务状态**
```bash
# 服务发现中心
open http://localhost:8761

# API网关
open http://localhost:8080

# 用户服务
open http://localhost:8081
```

4. **停止所有服务**
```bash
./stop.sh
```

### 方式二：Docker Compose启动

#### 前置条件
- Docker Desktop
- Docker Compose

#### 启动步骤

1. **构建并启动所有服务**
```bash
docker compose up -d
```

2. **查看服务状态**
```bash
docker compose ps
```

3. **查看日志**
```bash
docker compose logs -f
```

4. **停止所有服务**
```bash
docker compose down
```

## 📊 服务访问地址

| 服务名称 | 端口 | 访问地址 | 功能描述 |
|---------|------|----------|----------|
| **API网关** | 8080 | http://localhost:8080 | 统一入口，路由转发 |
| **服务发现** | 8761 | http://localhost:8761 | 服务注册与发现 |
| **配置中心** | 8888 | http://localhost:8888 | 配置管理 |
| **用户服务** | 8081 | http://localhost:8081 | 用户管理 |
| **内容服务** | 8082 | http://localhost:8082 | 内容管理 |
| **通知服务** | 8083 | http://localhost:8083 | 通知管理 |
| **搜索服务** | 8084 | http://localhost:8084 | 搜索功能 |

## 🔧 API接口示例

### 用户服务API

```bash
# 获取所有用户
curl http://localhost:8080/api/users

# 创建用户
curl -X POST http://localhost:8080/api/users \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "password123",
    "nickname": "测试用户"
  }'

# 根据ID获取用户
curl http://localhost:8080/api/users/1

# 搜索用户
curl http://localhost:8080/api/users/search/username?username=test
```

## 🛠️ 技术栈

- **Spring Boot 3.2.0** - 应用框架
- **Spring Cloud 2023.0.0** - 微服务框架
- **Spring Cloud Gateway** - API网关
- **Spring Cloud Netflix Eureka** - 服务发现
- **Spring Cloud Config** - 配置中心
- **Spring Data JPA** - 数据访问
- **H2 Database** - 内存数据库（开发环境）
- **Maven** - 构建工具
- **Docker** - 容器化部署

## 📁 项目结构

```
java-question-community/
├── api-gateway/           # API网关服务
├── config-server/         # 配置中心
├── discovery-server/      # 服务发现中心
├── user-service/          # 用户服务
│   ├── src/main/java/com/example/
│   │   ├── entity/        # 实体类
│   │   ├── repository/    # 数据访问层
│   │   └── controller/    # 控制器
│   └── src/main/resources/
│       └── application.yml
├── content-service/       # 内容服务
├── notification-service/  # 通知服务
├── search-service/        # 搜索服务
├── docker-compose.yml     # Docker编排文件
├── start.sh              # 启动脚本
├── stop.sh               # 停止脚本
└── README.md             # 项目说明
```

## 🔍 故障排查

### 常见问题

1. **端口被占用**
```bash
# 查看端口占用
lsof -i :8080

# 杀死进程
kill -9 <PID>
```

2. **服务启动失败**
```bash
# 查看日志
tail -f logs/*.log

# 检查Java版本
java -version
```

3. **Docker服务无法启动**
```bash
# 检查Docker状态
docker info

# 重启Docker Desktop
```

## 📝 开发指南

### 添加新服务

1. 创建服务目录
2. 添加pom.xml配置
3. 创建启动类和配置文件
4. 更新docker-compose.yml
5. 更新启动脚本

### 修改配置

- 开发环境：修改各服务的`application.yml`
- 生产环境：通过配置中心管理

## 🤝 贡献指南

1. Fork项目
2. 创建功能分支
3. 提交更改
4. 推送到分支
5. 创建Pull Request

## �� 许可证

MIT License 