# Project structure

This project contains the source code for both backend and mobile (flutter). It allows to run a fully functional app to log in via Google using AWS Cognito IDP.

- functions contains firebase function created when firebase was set
- .devcontainer contains a Docker file used within VSCode to creare an isolated environment to work with
- .vscode container the configuration to run in debug mode the flutter app on your device
- ./aws folder contains the infrastructure built with AWS to allow flutter app to login into AWS Cognito identity pool.

### deploy the infrastructure on AWS

tested with SAM CLI, version 1.133.0

1. deploy the infrastrucure on AWS (you need an active AWS account) using SAM and CloudFormation (you need sam cli installed on your computer).

```
cd aws
sam build
sam deploy --config-env "test"
```

## flutter

### design

![design](./design.png)

design credits: https://dribbble.com/shots/25519212-App-UI

### run the app

Run via adb debugging (wifi)

- Android: Go under "Wireless debugging" > "Pair device with pairing code"

Inside the container

```sh
adb pair [ip]:[port]
```

ip and port are given by the device on which wifi "Debug Wi-Fi" is enabled

- CLI: Enter the pairing code
- Android: Close the pairing screen & look at the "IP address and port

```sh
adb connect [ip]:[port]
adb devices
flutter run -d 192.168.0.102:40945
```

to run in debug mode add the following config inside .vscode/launch.json

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter on Device",
      "type": "dart",
      "request": "launch",
      "flutterMode": "debug",
      "deviceId": "192.168.0.102:40945"
    }
  ]
}
```

then go to "Run and Debug" menu in VSCode ad run using the above config

# Project setup

1. Create a new project in Firebase

2. Open the project in dev container and run
  
    1. login into your firebase account
    
        ```sh
        firebase login --no-localhost
        ```

    2. init firebase project

        ```sh
        firebase init
        ```
        - select at least one service from those seggested
        - choose 'Use an existing project' option

    3. configure flutterfire

        ```sh
        flutterfire configure --project=test-flutter--login-18920
        ```
        - select only android for this use case

    4. go to [firebase console](https://console.firebase.google.com/project/test-flutter--login-18920/authentication/providers)
        - under 'Authentication' setup Google provider
        - download google-services.json from project settings and replace it in android/app/google-services.json
    5. under project setting in Firebase provide SHA-1
        - for debug only
            ```sh 
            cd android
            ./gradlew signingReport
            ``` 

            fill *SHA-1 certificate fingerprints* Google's form field with the SHA1 printend in the console

        - for release only 
            - to create a key store (inside android/app folder)

                ```sh
                keytool -genkey -v -keystore my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
                ```

                for testing (ONLY) purposes we can use 'password' as password

            - to obtain SHA-1 key store

                ```sh
                keytool -list -v -keystore my-release-key.jks -alias my-key-alias
                ```

            - fill *SHA-1 certificate fingerprints* Google's form field with the SHA1 printend in the console

            - modify *android/gradle.properties* adding

                ```
                storeFile=my-release-key.jks
                storePassword=password
                keyAlias=my-key-alias
                keyPassword=password
                ```

            - modify *android/app/build.gradle* adding

                ```
                signingConfigs {
                    release {
                        storeFile file(project.property("storeFile"))
                        storePassword project.property("storePassword")
                        keyAlias project.property("keyAlias")
                        keyPassword project.property("keyPassword")
                    }
                }
                buildTypes {
                    release {
                        signingConfig signingConfigs.release
                    }
                }
                ```
3. update *aws/samconfig.yaml* modifying *GoogleClientId* and *GoogleClientSecret* with the value in *Google Auth Platform > Clients > OAuth 2.0 Client IDs > Web client (auto created by Google Service)*

4. deploy aws

    ```
    cd aws
    sam build
    sam deploy --config-env "test"
    ```