# Project structure

This project contains the source code for both backend and mobile (flutter). It allows to run a fully functional app to log in via Google using AWS Cognito IDP.

## backend

./backend folder contains the infrastructure built with AWS to allow flutter app to login into AWS Cognito identity pool.

### deploy the infrastructure on AWS

tested with SAM CLI, version 1.133.0

1. deploy the infrastrucure on AWS (you need an active AWS account) using SAM and CloudFormation (you need sam cli installed on your computer).

```
cd backend
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

# Google Cloud and Cognito IDP integration

ref: https://docs.aws.amazon.com/it_it/cognito/latest/developerguide/google.html

### Create OAuth client ID in Google Cloud

When setting up a Google Auth Platform client Google will ask you to create a *SHA-1 certificate fingerprint*. 

To create it a key store

1. to create a key store

```sh
keytool -genkey -v -keystore my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
```

2. to obtain SHA-1 key store

```sh
keytool -list -v -keystore my-release-key.jks -alias my-key-alias
```

3. fill *SHA-1 certificate fingerprint* Google's form field with the SHA1 printend in the console
