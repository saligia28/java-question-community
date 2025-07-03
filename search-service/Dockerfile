FROM openjdk:17-jdk-slim

WORKDIR /app

# 复制 Maven 配置文件
COPY pom.xml .
COPY src ./src

# 安装 Maven
RUN apt-get update && apt-get install -y maven

# 构建应用
RUN mvn clean package -DskipTests

# 运行应用
EXPOSE 8084
CMD ["java", "-jar", "target/search-service-0.0.1-SNAPSHOT.jar"] 