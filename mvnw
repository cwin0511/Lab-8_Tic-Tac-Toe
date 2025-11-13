#!/usr/bin/env sh
# ----------------------------------------------------------------------------
# Maven Wrapper
# ----------------------------------------------------------------------------
set -eu

MVNW_DIR="$(cd "$(dirname "$0")" && pwd)"
WRAPPER_DIR="$MVNW_DIR/.mvn/wrapper"
WRAPPER_JAR="$WRAPPER_DIR/maven-wrapper.jar"

if [ ! -f "$WRAPPER_JAR" ]; then
  mkdir -p "$WRAPPER_DIR"
  echo "Downloading maven-wrapper.jar..."
  # Try curl then wget
  if command -v curl >/dev/null 2>&1; then
    curl -sSfLo "$WRAPPER_JAR" "https://repo1.maven.org/maven2/io/takari/maven-wrapper/0.5.6/maven-wrapper-0.5.6.jar"
  elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$WRAPPER_JAR" "https://repo1.maven.org/maven2/io/takari/maven-wrapper/0.5.6/maven-wrapper-0.5.6.jar"
  else
    echo "Neither curl nor wget is available to download the maven wrapper jar." >&2
    exit 1
  fi
fi

JAVA_CMD="${JAVA_HOME:-}/bin/java"
if [ ! -x "$JAVA_CMD" ]; then
  JAVA_CMD="java"
fi

# Invoke the wrapper main class directly (use -cp) to avoid jars missing Main-Class manifest
exec "$JAVA_CMD" -Dmaven.multiModuleProjectDirectory="$(pwd)" -cp "$WRAPPER_JAR" org.apache.maven.wrapper.MavenWrapperMain "$@"
