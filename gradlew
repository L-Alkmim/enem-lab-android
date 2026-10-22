#!/bin/sh
cd "$(dirname "$0")" || exit 1
exec java -cp gradle/wrapper/gradle-wrapper.jar org.gradle.wrapper.GradleWrapperMain "$@"
