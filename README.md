# A Linux Bash Script to Fully Backup Android Apps and Data
A comand line bash script to fully bakcup and restore an Android device (Apps+Data). It doesn't require any user action like tapping "OK" and similar. The script checks if any backup is already present and skips them if needed. Only new apps and missing data are backed up

# How-to
1) Create a new directory "MyDevice"
2) Copy backupAndRestoreAndroidDevide.sh in "MyDirectory" and go to to "MyDirectory"
3) Connect your device thought ADB in Debug Mode, for instance, using USB cable
4) Bakcup all your apps and data typining
```
bash backupAndRestoreAndroidDevide.sh backup
```
5) Wait for the process to end
6) Connect the device you want to restor the backup to
7) Restore all apps and data typing
```
bash backupAndRestoreAndroidDevide.sh restore
```

# Important notice:
Sometimes ADB hangs, you can halt and restar the script safely.
The script checks if the backup is already present and skips it if needed.
