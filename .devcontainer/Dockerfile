FROM mcr.microsoft.com/devcontainers/base:ubuntu

#
# Install needed packages, setup user and clean up.
RUN  apt update \
    && apt install -y wget curl git xz-utils zip unzip --no-install-recommends
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
#
# Flutter SDK
# https://flutter.dev/docs/development/tools/sdk/releases?tab=linux
ENV FLUTTER_CHANNEL="stable"
ENV FLUTTER_VERSION="3.24.3"
# Make sure to use the needed channel and version for this.
ENV FLUTTER_HOME=/usr/local/flutter
ENV PATH=${PATH}:${FLUTTER_HOME}/bin

#
# Flutter SDK
RUN curl -C - --output flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/${FLUTTER_CHANNEL}/linux/flutter_linux_${FLUTTER_VERSION}-${FLUTTER_CHANNEL}.tar.xz \
    && tar -xf flutter.tar.xz -C /usr/local \
    && rm flutter.tar.xz* \
    && chown -R vscode:vscode /usr/local/flutter

USER vscode    

# Ensure the Flutter PATH is available for zsh and bash shells
RUN echo "export FLUTTER_HOME=/usr/local/flutter" >> ~/.zshrc \
    && echo "export PATH=\$PATH:\$FLUTTER_HOME/bin" >> ~/.zshrc \
    && echo "export FLUTTER_HOME=/usr/local/flutter" >> ~/.bashrc \
    && echo "export PATH=\$PATH:\$FLUTTER_HOME/bin" >> ~/.bashrc