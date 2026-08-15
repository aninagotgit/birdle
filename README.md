# birdle

A new Flutter project.

# Useful terminal commands

Run the app in chrome:

```
flutter run -d chrome
```

Hot reload app:

```
r
```

To use devtools: 
- Run your app, note the A Dart VM Service on Chrome is available at: NOTE_URL_HERE
- In a new terminal: 
```
dart devtools
```
- In the devtools popup, paste the VM URL
* OR 
- Run app with play button in intellij, look for `open flutter devtools in browser`
# Notes

- Always extend StatelessWidget unless you have a reason not to
- StatefulWidget if the widget needs to change in appearance