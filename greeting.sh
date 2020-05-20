#!/usr/bin/env bash
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=bash
# encoding: utf-8

MORNING='\U1F319'
AFTERNOON='\U2600'
EVENING='\U1F316'
NIGHT='\U1F319'

time_of_day="morning $MORNING"
hour=`date | cut -c 12-13`
if [ $hour -gt 11 ]; then
   time_of_day="afternoon $AFTERNOON"
fi
if [ $hour -gt 17 ]; then
   time_of_day="evening $EVENING"
fi
if [[ $hour -gt 21 || $hour -lt 5 ]]; then
   time_of_day="night $NIGHT"
fi

if [[ $(uname) == "Darwin" ]]; then
    #mac_name=`awk '/SOFTWARE LICENSE AGREEMENT FOR macOS/' '/System/Library/CoreServices/Setup Assistant.app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf' | awk -F 'macOS ' '{print $NF}' | awk '{print substr($0, 0, length($0)-1)}'`
    mac_name=`cat '/System/Library/CoreServices/Setup Assistant.app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf' | ggrep -P 'SOFTWARE LICENSE AGREEMENT FOR\s+([^\\\]*)' | awk '{ printf "%s %s\n", $6, substr($7, 0, length($7) -1) }'`
    mac_version=`sw_vers | sed -n '2,$p' | awk -F':\t' '{print $2}' | paste -d '. ' - -`
    cpu64bit_capable=$(sysctl -n hw.cpu64bit_capable)
    if [ $cpu64bit_capable -eq 1 ]; then
        mac_arch="x86-64"
    else
        mac_arch="x86"
    fi
    os_name="$mac_name $mac_version ($mac_arch)"
else
    linux_name=`cat /etc/os-release | pcregrep -o1 "^NAME=\"([^\"]+)"`
    linux_version=`cat /etc/os-release | pcregrep -o1 "VERSION=\"([^\"]+)"`
    linux_arch=`hostnamectl | pcregrep -o0 "Architecture:\s*(.*)"`
    os_name="$linux_name $linux_version ($linux_arch)"
fi

echo
fortune softwareengineering
echo
printf "Good $time_of_day and welcome to $os_name\n\n"
