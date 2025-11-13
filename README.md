# TicTacToe

Simple TicTacToe implementation in Java with JUnit tests and GitHub Actions workflow.

How to run tests locally (Windows PowerShell):

```powershell
mvn test
```

If you don't have Maven installed, you can bootstrap the official Maven Wrapper (creates `mvnw`, `mvnw.cmd`, and `./.mvn/wrapper/*`) by running the provided PowerShell script once:

```powershell
.\bootstrap-maven-wrapper.ps1
```

After that run the tests with:

```powershell
.\mvnw.cmd test
```

Project structure:
- src/main/java - implementation
- src/test/java - JUnit tests
- .github/workflows/maven.yml - CI to run tests on push
