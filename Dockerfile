# Build the static site with Jekyll
FROM jekyll/jekyll:stable as builder

# Copy sources
COPY . /srv/jekyll

# Set workdir
WORKDIR /srv/jekyll

# Install gems and build site
#RUN bundle install && \
RUN JEKYLL_ENV=production jekyll build

# Build nginx container
FROM nginx:latest

# Copy build artifacts
COPY --from=builder /srv/jekyll/_site /usr/share/nginx/html

# Expose the web port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

