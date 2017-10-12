FROM gradle:jdk8-alpine

MAINTAINER Raymond Wen "rx.wen218@gmail.com"

ENV ANDROID_SDK_VERSION 3859397

RUN apk update && apk add -y unzip curl wget openssl make

# Install Android SDK
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
        && mkdir /opt/android_sdk \
        && unzip -C /opt/android_sdk/ sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
        && rm sdk-tools-linux-${ANDROID_SDK_VERSION}.zip

# Setup environment
ENV ANDROID_HOME /opt/android-sdk
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools/bin;
RUN curl -L http://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-linux-x86_64.zip | bsdtar -xf- -C /opt/
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
RUN chmod a+x /usr/bin/repo

# Install sdk components
RUN yes | sdkmanager --licenses
RUN sdkmanager --list --verbose
RUN sdkmanager --update

