# flutter_mobile_app_template

Templates for mobile app projects using flutter.  
The environment variable `--dart-define=OPERATION_TYPE` at build time switches firebase project, api connecting destination, and others.

- Firebase configuration file is empty, so overwrite the files under `android/app/firebase` and under `ios/firebase`.

## Switching operating environment

In case of Android, switch settings by the script in `android/app/build.gradle`. In case of iOS, execute `ios/Scripts/dart_define.sh` from Xcode script execution settings, and change the xcconfig file according to your environment.

### OPERATION_TYPE

product, staging, review, develop

- Separate app name, ID, and Firebase configuration files for `product` and others
- In settings other than `product`, the id is suffixed with `.dev`.

## Application architecture

Divide responsibilities among the four roles of `View`, `ViewModel`, `UseCase`, and `Repository`.

### View

UI display and control.

### ViewModel

UI update notification to View and maintenance of status, bridging with UseCase.

### UseCase

Responsible for business logic.

### Repository

Responsible for bridging with DB and other external parties.

## Unit test

The `.di` constructor defined for testing is used to increase testability.

```
@visibleForTesting
SampleClass.di(this._sample);
```

Since it is necessary to create a mock class by Mockito, set up `@GenerateMocks` and execute the following commands.

```
flutter pub run build_runner build --delete-conflicting-outputs
```

## Folder structure

### common

Classes used by multiple components.

### const

Static definition file.

### dialog

Dialog classes.

### entity

Data classes that are exchanged between APIs and objects.

### exception

Exception classes.

### provider

Mixin classes for Provider access in the State class.

### repository

Classes that interact with the outside.

### route_observer

Screen transition monitoring classes.

### view

A screen classes that serves as a unit for screen transitions.

- Create a folder for each screen.
