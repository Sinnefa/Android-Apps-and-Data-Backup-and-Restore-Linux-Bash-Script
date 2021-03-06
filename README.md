# A Linux Bash Script to Fully Backup Android Apps and Data
A command line bash script to fully back-up and restore an Android device (Apps+Data). It doesn't require any user action like tapping "OK" and similar.
The script does an incremental back-up. It checks if any back-up file is already present in the running directory and skips it if needed. Only new apps and missing data are backed up. This script will not back-up messages and calls. Adding the "-shared" flash where indicated also backs up SD data.

# How-to
0) Enable "Dveloper Options" https://developer.android.com/studio/debug/dev-options on your device.
1) Create a new directory "MyDevice" in your computer
2) Copy backupAndRestoreAndroidDevide.sh in "MyDirectory" and go to to "MyDirectory"
3) Connect your device thought ADB in Debug Mode, for instance, using USB cable
4) Bakcup all your apps and data typining
```
bash backupAndRestoreAndroidDevide.sh backup
```
5) Wait for the process to end
6) Connect the device you want to restor the back-up to
7) Restore all apps and data typing
```
bash backupAndRestoreAndroidDevide.sh restore
```

# Important Notes:

1) The script simulates a tap on the screen to start app backup, if coordinates in the script are wrong, edit the script.
2) Sometimes ADB hangs, you can halt and restar the script safely.
3) The script checks if the back-up is already present and skips it if needed.
