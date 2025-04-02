FROM nginx:alpine

# Copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 7070
EXPOSE 7070

CMD ["nginx", "-g", "daemon off;"]