FROM ghcr.io/cirruslabs/flutter:3.27.1

# Install adb
RUN apt-get update && apt-get install -y adb wget unzip curl && apt-get clean

# Install Firebase CLI
RUN curl -sL https://firebase.tools | bash

# Install FlutterFire CLI
RUN dart pub global activate flutterfire_cli

# Set up Android NDK
ENV ANDROID_NDK_VERSION=22
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV ANDROID_NDK_HOME=$ANDROID_HOME/ndk/$ANDROID_NDK_VERSION

# Download and install the NDK
RUN mkdir -p $ANDROID_HOME/ndk && \
    wget https://dl.google.com/android/repository/android-ndk-r$ANDROID_NDK_VERSION-linux-x86_64.zip -O /tmp/ndk.zip && \
    unzip /tmp/ndk.zip -d $ANDROID_HOME/ndk && \
    mv $ANDROID_HOME/ndk/android-ndk-r$ANDROID_NDK_VERSION $ANDROID_NDK_HOME && \
    rm /tmp/ndk.zip

# Ensure the NDK is in the PATH
ENV PATH="$ANDROID_NDK_HOME:$PATH"

# For FlutterFire CLI
ENV PATH="/root/.pub-cache/bin:$PATH"

