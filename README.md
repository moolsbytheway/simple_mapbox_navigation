# simple_mapbox_navigation

Simple mapbox navigation UI (Still WIP, adding latest touches)

Add Turn By Turn Navigation to Your Flutter Application Using MapBox. Never leave your app when you need to navigate your users to a location.

# Screenshots
<img src="https://raw.githubusercontent.com/moolsbytheway/simple_mapbox_navigation/main/screenshots/ios.webp" alt="Navigation View" title="iOS" width="300"> | <img src="https://raw.githubusercontent.com/moolsbytheway/simple_mapbox_navigation/main/screenshots/android.webp" alt="Android View" title="Android" width="300">

## Features

* A full-fledged turn-by-turn navigation UI for Flutter that’s ready to drop into your application
* [Professionally designed map styles](https://www.mapbox.com/maps/) for daytime and nighttime driving
* Worldwide driving, cycling, and walking directions powered by [open data](https://www.mapbox.com/about/open/) and user feedback
* Traffic avoidance and proactive rerouting based on current conditions in [over 55 countries](https://docs.mapbox.com/help/how-mapbox-works/directions/#traffic-data)
* Natural-sounding turn instructions powered by [Amazon Polly](https://aws.amazon.com/polly/) (no configuration needed)
* [Support for over two dozen languages](https://docs.mapbox.com/ios/navigation/overview/localization-and-internationalization/)

## IOS Configuration

1. Go to your [Mapbox account dashboard](https://account.mapbox.com/) and create an access token that has the `DOWNLOADS:READ` scope. **PLEASE NOTE: This is not the same as your production Mapbox API token. Make sure to keep it private and do not insert it into any Info.plist file.** Create a file named `.netrc` in your home directory if it doesn’t already exist, then add the following lines to the end of the file:
   ```
   machine api.mapbox.com
     login mapbox
     password PRIVATE_MAPBOX_API_TOKEN
   ```
   where _PRIVATE_MAPBOX_API_TOKEN_ is your Mapbox API token with the `DOWNLOADS:READ` scope.

1. Mapbox APIs and vector tiles require a Mapbox account and API access token. In the project editor, select the application target, then go to the Info tab. Under the “Custom iOS Target Properties” section, set `MBXAccessToken` to your access token. You can obtain an access token from the [Mapbox account page](https://account.mapbox.com/access-tokens/).

1. In order for the SDK to track the user’s location as they move along the route, set `NSLocationWhenInUseUsageDescription` to:
   > Shows your location on the map and helps improve OpenStreetMap.

1. Users expect the SDK to continue to track the user’s location and deliver audible instructions even while a different application is visible or the device is locked. Go to the Capabilities tab. Under the Background Modes section, enable “Audio, AirPlay, and Picture in Picture” and “Location updates”. (Alternatively, add the `audio` and `location` values to the `UIBackgroundModes` array in the Info tab.)


## Android Configuration

1. Mapbox APIs and vector tiles require a Mapbox account and API access token. Add a new resource file called `mapbox_access_token.xml` with it's full path being `<YOUR_FLUTTER_APP_ROOT>/android/app/src/main/res/values/mapbox_access_token.xml`. Then add a string resource with name "mapbox_access_token" and your token as it's value as shown below. You can obtain an access token from the [Mapbox account page](https://account.mapbox.com/access-tokens/).
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources xmlns:tools="http://schemas.android.com/tools">
    <string name="mapbox_access_token" translatable="false" tools:ignore="UnusedResources">ADD_MAPBOX_ACCESS_TOKEN_HERE</string>
</resources>
```

2. Add the following permissions to the app level Android Manifest
```xml
<manifest>
    ...
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    ...
</manifest>
```

3. Add the MapBox Downloads token with the ```downloads:read``` scope to your gradle.properties file in Android folder to enable downloading the MapBox binaries from the repository. To secure this token from getting checked into source control, you can add it to the gradle.properties of your GRADLE_HOME which is usually at $USER_HOME/.gradle for Mac. This token can be retrieved from your [MapBox Dashboard](https://account.mapbox.com/access-tokens/). You can review the [Token Guide](https://docs.mapbox.com/accounts/guides/tokens/) to learn more about download tokens
```text
MAPBOX_DOWNLOADS_TOKEN=sk.XXXXXXXXXXXXXXX
```

After adding the above, your gradle.properties file may look something like this:
```text
org.gradle.jvmargs=-Xmx1536M
android.useAndroidX=true
android.enableJetifier=true
MAPBOX_DOWNLOADS_TOKEN=[[YOUR_MAPBOX_SECREY_KEY]]
```


## Getting Started

Usage is simple as calling the method `startNavigation` with the origin and destination coordinates.
The Mapbox turn by turn navigation will open in full screen; when closed it will come back to your main activity.

- Initialize the plugin

```dart
  final mapBoxNavigation = MapboxNavigation();
```

- Launch the map

```dart
  mapBoxNavigation.startNavigation(origin_latitude, origin_longitude, target_latitude, target_longitude)
```

## Example
```dart
import 'package:flutter/material.dart';

import 'package:simple_mapbox_navigation/simple_mapbox_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final mapBoxNavigation = MapboxNavigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Mapbox navigation launcher')),
            body: Center(
                child: Column(children: [
              const Text("From: 33.605917, -7.520119"),
              const Text("To: 33.607320, -7.516551"),
              ElevatedButton(
                onPressed: _openMap,
                child: const Text("Open map"),
              )
            ]))));
  }

  void _openMap() {
    mapBoxNavigation.startNavigation(
        33.605917, -7.520119, 33.607320, -7.516551);
  }
}
```