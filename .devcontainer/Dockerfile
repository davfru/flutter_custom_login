FROM ghcr.io/cirruslabs/flutter:3.27.1

# Install adb for device communication
RUN apt-get update && apt-get install -y adb wget unzip && apt-get clean

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
