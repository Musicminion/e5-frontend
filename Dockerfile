# Base image
FROM node:16.19.1-alpine as build

# Set the working directory
WORKDIR /app

# 拷贝 Angular 项目文件到工作目录中
COPY . .

# 安装依赖
RUN npm install

# 构建 Angular 项目
RUN npm run build --prod

# 构建 Apache 镜像
FROM httpd:2.4

COPY --from=build /app/dist/e5-html /usr/local/apache2/htdocs/

# 启用 Apache 的 mod_rewrite 模块
RUN sed -i '/<Directory "\/usr\/local\/apache2\/htdocs">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /usr/local/apache2/conf/httpd.conf

# 暴露 Apache 端口
EXPOSE 80

# 启动 Apache 服务器
CMD ["httpd-foreground"]