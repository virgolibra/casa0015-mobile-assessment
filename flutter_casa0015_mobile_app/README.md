# flutter_casa0015_mobile_app

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

----

Update 14 Mar 2022



Possible useful links

https://pub.dev/packages/geolocator

https://pub.dev/packages/weather

https://codelabs.developers.google.com/codelabs/google-maps-in-flutter#0

https://stackoverflow.com/questions/55000043/flutter-how-to-add-marker-to-google-maps-with-new-marker-api



https://www.youtube.com/watch?v=5fzdvPnp5bY





---

Update 05 Apr 2022



##### Idea

Create 2 mode:

+ login mode: files and data store in cloud
+ Non login mode (local mode): store files and data locally



Develop local mode first.



Upload files with Cloud Storage on Android

https://firebase.google.com/docs/storage/android/upload-files



**What have done:**

+ Add SizedBox to limit the buttons widths and heights



---

Update 07 Apr 2022

**What have done:**

+ Use FractionallySizedBox to control the sizebox with factors
+ [Add a marker to the map](https://www.codegrepper.com/code-examples/whatever/flutter+google+map+marker)
+ Get user current location and add to map



-----

Update 06 May 2022



Q: Google map exceeded sample count in FrameTime



----

Update 07 May 2022

https://pub.dev/packages/weather

https://openweathermap.org/

OpenWeather API

https://openweathermap.org/weather-conditions

weather conditions



Add test weather page

**What have done:**

+ Fetch weather based on current location (Temp, humidity, icon, etc).

------

Update 09 May 2022

+ Fix weather icon null display problem



-----------------

Update 10 May 2022

+ Taking a picture using camera

https://docs.flutter.dev/cookbook/plugins/picture-using-camera

**Add dependencies**

camera https://pub.dev/packages/camera

path_provider https://pub.dev/packages/path_provider

path https://pub.dev/packages/path



----

Update 11 May 2022

+ Add a login page
+ Test Firebase function
+ Modify login UI

----

Update 12 May 2022

+ Create a message test page to test firebase communication on a new page
+ Test to add a type field to firebase collection



~~To be solved: How to select the unique user data and display.~~



Listview builder

https://api.flutter.dev/flutter/widgets/ListView-class.html



---

Update 13 May 2022



https://stackoverflow.com/questions/54332574/flutter-interactive-listtile-in-listview

https://juejin.cn/post/6844903957328838663





timestamp to datetime

https://stackoverflow.com/questions/62125633/how-to-convert-timestamp-to-datetime-from-firebase-with-flutter



To be solved: List view exceed boundary



-----

Update 14 May 2022

Try to optimise main page



Pass argument to stateful widgets:

Do not pass parameters to `State` using it's constructor. Only access the parameters using `widget.myField`.



+ Fix cannot keep login problem
