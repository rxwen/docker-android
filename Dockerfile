FROM ubuntu:14.04

MAINTAINER Raymond Wen "rx.wen218@gmail.com"

ENV ANDROID_SDK_VERSION 24.4.1
ENV GRADLE_VERSION 3.4.1
ENV NDK_VERSION r14b
# Install java8
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository -y ppa:webupd8team/java && apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer bsdtar

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl make openssl

# Install Android SDK
RUN curl -L http://dl.google.com/android/android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz | bsdtar -xf- -C /opt/

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
RUN curl -L https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip | bsdtar -xf- -C /opt/
RUN curl -L http://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-linux-x86_64.zip | bsdtar -xf- -C /opt/
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
RUN chmod a+x /usr/bin/repo
# make sure applications executable
RUN chmod +x -R /opt/

# Install sdk components
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools:/opt/gradle-${GRADLE_VERSION}/bin/
RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --force --no-ui --filter platform-tools,tools,build-tools-19.1.0,build-tools-21,build-tools-21.0.1,build-tools-21.0.2,build-tools-21.1,build-tools-21.1.1,build-tools-21.1.2,build-tools-22,build-tools-22.0.1,build-tools-23.0.2,build-tools-23.0.3,build-tools-24.0.3,build-tools-25,build-tools-25.0.3,build-tools-26.0.2,android-21,android-22,android-23,android-25,android-19,addon-google_apis_x86-google-21,extra-android-support,extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services,sys-img-armeabi-v7a-android-21"]

# Cleaning
RUN apt-get clean
