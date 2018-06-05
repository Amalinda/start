start

This repo is for my reference. It installs GNURadio, Ettus UHD, Inspectrum and all other software I use on a daily basis to a fresh Debian system at a stretch with no further querries untill end. It saves about 6 hours of my precious time.
Advice

The installation takes about 2-3 hours even on a fast PC. Hence, do the following first prior to starting this script & sustain sudo privilages throughout the process. Else, the script will be waiting to re-type the password when you come back.
Step 1: Enable sustaned sudo privilages (can be a security bug depending on your perception)

#editing this file directly is dangerous. Do exactly as said and change nothing else. sudo visudo
Change the line: "Defaults env_reset" to "Defaults env_reset,timestamp_timeout=-1"
Step 2: Run the following command

sudo apt-get update -y && sudo apt-get install git -y && git clone https://github.com/Amalinda/start.git && cd start/ && chmod +x start.sh && ./start.sh
