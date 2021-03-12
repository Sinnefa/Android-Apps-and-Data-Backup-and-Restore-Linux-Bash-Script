echo "This application backups and restors all Android apps and data"
echo "It needs one parameter 'backup' or 'restore' depending on the oprations you want to perform"
echo "DON'T TOUCH you device during any operation. If the process hangs for too long just restart this application"
echo ""
echo "Action: $1" # Action backup | restore-apk
echo "$2" # TEST NEEDED: Text to capture to confirm operation
sleep=5
if [[ $1 == "restore" ]] # Restores all files contained in a directory
then
	echo "Installing APPS"
	for i in *.apk
	do
		echo "Installing $i"
		adb install $i
	done
	echo "Restoring data"
	for i in *.adb
	do
		echo "Restoring data for $i"
		adb restore $i &
		sleep $sleep
		if [ ! -f view.xml ] ; then # grabs screen layout to tap "OK"
			adb </dev/null pull $(adb shell uiautomator dump | grep -oP '[^ ]+.xml') view.xml
		fi
		# In case it doesen't work, see the view.xml file to find the "OK" button to be virtualy clicked and fix the regexp
		# coords=$(perl -ne 'printf "%d %d\n", ($1+(($3-$1)/2)), ($2+(($4-$2)/2)) if /resource-id=".*?button_allow"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"/' view.xml) # Older Android devices
		coords=$(perl -ne 'printf "%d %d\n", ($3-10), ($4-10) if /text="$2"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"/' view.xml)
		echo "Don't touch your device, automatially tapping at $coords"
		sleep $sleep
		adb shell input tap $coords # Virtually tapping screen
		sleep $sleep
		wait
	done
fi
if [[ $1 == "backup" ]]
then
	for i in $(adb shell 'pm list packages -3' | cut -f2 -d:) # Gets all user installed apps
	do
		i=$(echo $i | sed -e 's/\r//g')
		echo "APP $i"
		if find $i.apk -type f -size +100k 2>/dev/null | grep -q .; then # Checks if backup file exists
		        echo "App $i already present"
		else # Extracts app APK and renames it correctly
			tmp=$(adb shell pm path $i | head -1 | cut -f2 -d: | sed -e 's/\r//g')
			echo "Getting $tmp"
			adb pull $tmp
			tmp=$(basename $tmp)
			mv $tmp $i.apk
		fi
		echo "DATA $i"
		if find $i.adb -type f -size +100k 2>/dev/null | grep -q .; then # Checks if data already backed up
			echo "Data for $i already present"
		else
			echo "Backing up data for $i"
			adb backup -f $i.adb -apk $i & # Add -shared to backup SD as well BIG FILES will be generated
			sleep $sleep
			if [ ! -f view.xml ] ; then
				adb pull $(adb shell uiautomator dump | grep -oP '[^ ]+.xml') view.xml
			fi
			coords=$(perl -ne 'printf "%d %d\n", ($3-10), ($4-10) if /text="$2"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"/' view.xml)
			echo "Don't touch your device, automatially tapping at $coords"
			sleep $sleep
			adb shell input tap $coords
			wait
		fi
	done 
fi
rm view.xml
