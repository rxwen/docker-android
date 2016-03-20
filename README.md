# android-java8

This docker is to build Android Gradle project with Java 8.
It is available on Docker Hub https://registry.hub.docker.com/u/rxwen/android/ .

Contains:

* Android SDK: r24.4.1
* Build tools: 19.0.1, 21.1.2, 22.0.1, 23.0.2
* Android API: 23, 22, 21, 19
* Support maven repository
* Google maven repository
* Arm emulator: v21
* Platform tools
* Ndk: r11b
* Gradle: 2.2.1

## Build image

```bash
docker build -t rxwen/android .
```


```bash
docker run --tty --interactive --rm 1b372b1f76f2 /bin/bash
```

