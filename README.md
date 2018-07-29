

This repo is for my reference. It installs open SDR based software I use on a daily basis to a fresh Debian box at a stretch with no querries untill end. It saves about 6 hours.

The installation takes about 2-3 hours even on a fastest PC. Hence, do the following prior to starting the script to sustain sudo privilages throughout the process. Else, the script will be stop and expect you to re-enter sudo password when you return.


STEP 1: Enable sustaned sudo privilages (can be a security bug depending on your perception)

#editing this file directly is dangerous. Do exactly as said and change nothing else. 
sudo visudo

Change the line: "Defaults env_reset" to "Defaults env_reset,timestamp_timeout=-1"


STEP 2: Run the following command

sudo apt-get update -y && sudo apt-get install git -y && git clone https://github.com/Amalinda/start.git && cd start/ && chmod +x 

start.sh && ./start.sh
