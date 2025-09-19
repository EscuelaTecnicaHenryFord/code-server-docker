FROM lscr.io/linuxserver/code-server:latest

# Set the user to root
USER root

# Apt update upgrade
RUN apt-get update && apt-get upgrade -y

# Install C and C++ related tools
RUN apt-get install -y build-essential gdb valgrind

# Install gcc, g++, clang, clang++, make, cmake, ninja-build
RUN apt-get install -y gcc g++ clang cmake ninja-build

# Install Python related tools
RUN apt-get install -y python3 python3-pip

# Install unzip
RUN apt-get install -y unzip

# Install node
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install 22

# Install BUN
RUN curl -fsSL https://bun.sh/install | bash

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install wget
RUN apt-get install -y wget

# Install Go
RUN wget https://golang.org/dl/go1.23.4.linux-amd64.tar.gz && \
    sudo tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz && \
    rm go1.23.4.linux-amd64.tar.gz

# Install Dart
RUN apt-get install apt-transport-https && \
    wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub \
    | gpg  --dearmor -o /usr/share/keyrings/dart.gpg && \
    echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
    | tee /etc/apt/sources.list.d/dart_stable.list && \
    apt-get update && sudo apt-get install dart

# Install extensions
RUN code-server --install-extension DEVSENSE.phptools-vscode --user-data-dir /data && \
    code-server --install-extension Dart-Code.dart-code --user-data-dir /data && \
    code-server --install-extension astro-build.astro-vscode --user-data-dir /data && \
    code-server --install-extension ms-vscode.cpptools --user-data-dir /data && \
    code-server --install-extension ms-python.python --user-data-dir /data && \
    code-server --install-extension GitHub.copilot --user-data-dir /data && \
    code-server --install-extension junstyle.php-cs-fixer --user-data-dir /data || true

# Set the user to root
USER root
    
