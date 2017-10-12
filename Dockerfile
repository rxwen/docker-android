FROM rxwen/ubuntu-jdk

MAINTAINER Raymond Wen "rx.wen218@gmail.com"

ENV ANDROID_SDK_VERSION 3859397
ENV GRADLE_VERSION 3.4.1

USER root
RUN apt-get update && apt-get install -y zip unzip curl wget openssl make openssh-client git python libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1

# Install Android SDK
ENV ANDROID_HOME /opt/android-sdk
# the ndk-bundle vr15b doesn't compile out code, force r14
RUN mkdir -p $ANDROID_HOME && wget https://dl.google.com/android/repository/android-ndk-r14b-linux-x86_64.zip \
        && unzip -q -d ${ANDROID_HOME} androi-ndk-r14b-linux-x86_64.zip \
        && mv ${ANDROID_HOME}/android-ndk-r14b ${ANDROID_HOME}/ndk-bundle \
        && rm android-ndk-r14b-linux-x86_64.zip \
