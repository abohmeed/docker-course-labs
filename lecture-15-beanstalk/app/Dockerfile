# Lecture 15: static site on nginx, deployed to Elastic Beanstalk (Docker on AL2023)
# Public ECR mirror avoids Docker Hub pull limits on the EC2 instance.
FROM public.ecr.aws/nginx/nginx:stable-alpine
COPY site/ /usr/share/nginx/html/
# Beanstalk's host nginx proxies port 80 to the first EXPOSE port.
EXPOSE 80
