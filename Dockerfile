FROM ubuntu:18.04
 
# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    unzip
 
# Install Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable
ENV PATH "$PATH:/flutter/bin/cache/dart-sdk/bin:/flutter/bin"
RUN flutter --version
RUN flutter precache
 
# Build the Flutter web app
COPY . /app
WORKDIR /app
RUN flutter build web --release
 
# Expose the port used by the app
EXPOSE 8080
 
# Start the app
CMD ["flutter", "run", "-d", "web"]
