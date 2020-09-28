install-junit() {
 curl -L 'https://search.maven.org/remotecontent?filepath=junit/junit/4.13/junit-4.13.jar' \
      -o "$HOME/.local/bin/junit.jar"

curl -L 'https://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar' \
     -o "$HOME/.local/bin/hamcrest-core.jar"
}
