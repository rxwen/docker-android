FROM gradle:jdk8-alpine

MAINTAINER Raymond Wen "rx.wen218@gmail.com"

ENV ANDROID_SDK_VERSION 3859397

USER root
RUN apk update && apk add -f zip unzip curl wget openssl make openssh git python

# Install Android SDK
ENV ANDROID_HOME /opt/android-sdk
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
        && mkdir -p ${ANDROID_HOME} \
        && unzip -d ${ANDROID_HOME} sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
        && rm sdk-tools-linux-${ANDROID_SDK_VERSION}.zip

# Setup environment
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools/bin;
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
RUN chmod a+x /usr/bin/repo

# Install sdk components
RUN yes | sdkmanager --licenses
RUN sdkmanager --list
RUN sdkmanager --update --verbose
RUN sdkmanager \
        "build-tools;19.1.0" \
        "build-tools;20.0.0" \
        "build-tools;21.1.2" \
        "build-tools;23.0.3" \
        "build-tools;24.0.3" \
        "build-tools;25.0.3" \
        "build-tools;26.0.2" \
        "cmake;3.6.4111459" \
        "extras;android;m2repository" \
        "ndk-bundle" \
        "platform-tools" \
        "platforms;android-26" \
        "platforms;android-25" \
        "platforms;android-23" \
        "platforms;android-22" \
        "platforms;android-20" \
        "platforms;android-19" \
        "platforms;android-13" \
        "platforms;android-10" \
        "platforms;android-8"
RUN sdkmanager --list
