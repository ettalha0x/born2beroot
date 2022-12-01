# born2beroot
a 42 Cursus project (monitoring.sh script, walk through installation and setting up, evaluation Q&amp;A)
--------------------------------------------------------------------------------
STEP 1 - setup your VM machine
--------------------------------------------------------------------------------
Don't forget to set up encrypted LVM

--------------------------------------------------------------------------------
STEP 2 - Configure your machine
--------------------------------------------------------------------------------

Enter your LVM encryption passphrase, log in into your user.
Now we are going to install necessary software and configure it.

........................................................
substep 2.1 - Installing sudo & adding user in groups
........................................................

1) su - -> root password -> apt install sudo
2) [$ adduser <yourusername> sudo] (yep, you should be in root)
3) [$ sudo reboot], then log in again
4) [$ sudo -v] -> password
5) [$ sudo addgroup user42]
6) [$ sudo adduser yourusername user42]
7) [$ sudo apt update]
........................................................
substep 2.2 - Installing SSH
........................................................

1) [$ sudo apt install openssh-server]
2) [$ sudo nano /etc/ssh/sshd_config] -> change line "#Port 22" to "Port 4242" and
"#PermitRootLogin prohibit-password" to "PermitRootLogin no" -> save and exit
(i hope you know how to do it in Nano...)
3) [$ sudo nano /etc/ssh/ssh_config] -> change line "#Port 22" to "Port 4242"
4) [$ sudo service ssh status]. It's should be active.
........................................................
substep 2.3 - Installing UFW
........................................................

1) [$ sudo apt install ufw]
2) [$ sudo ufw enable]
3) [$ sudo ufw allow 4242]
4) [$ sudo ufw status]. It's should be active with 4242 and 4242(v6) ports allow
from anywhere
........................................................
substep 3.4 - Configuring sudo
........................................................

1) [$ sudo visudo] (open  /etc/sudoers.tmp file)
2) then write next lines and save:
  
  ************************************************************
  * Defaults      passwd_tries=3                             *
  * Defaults      badpass_message="Incorrect password"       * <- you can set your
  * Defaults      log_input,log_output                       *    own message here
  * Defaults      iolog_dir="/var/log/sudo"                  *
  * Defaults      requiretty                                 *
  * Defaults      secure_path="that/long/paths/from/subject" *
  ************************************************************
                                                                  
........................................................
substep 3.5 - Setting up a strong password policy
........................................................
                                                                  
1) [$ sudo nano /etc/login.desf] (open login.defs file)
2) replace next lines :
                                                                  
*************************************************
* PASS_MAX_DAYS    99999 -> PASS_MAX_DAYS    30 * <- line 160 you can easly
* PASS_MIN_DAYS    0     -> PASS_MIN_DAYS    2  *    reach it with ctrl+_ in
*************************************************    nano
  
PASS_WARN_AGE is 7 by default so we just ignore it 
3) [$ sudo apt install libpam-cracklib] (install libpam cracklib so we have more option for password policy)
4) [$ sudo nano /etc/pam.d/common-password] (open common-password file so we can add more password policy rules )
5) Add to the end of the "password requisite pam_cracklib.so retry=3" line next
   parameters

  ****************************************************************************************
  * minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 difok=7 enforce_for_root *
  ****************************************************************************************
  
6) Now you have to change all your passwords according to your new password
    policy
*******************
* [$ passwd]      * <- change user password
* [$ sudo passwd] * <- change root password
*******************

--------------------------------------------------------------------------------
STEP 4 - Network adapter configuration
--------------------------------------------------------------------------------

You may not be able to connect to your VM via SSH with standard settings in
VirtualBox. Theres a way to wix it!

1) Turn off your VM ([sudo shutdown])
2) Go to your VM settings in VirtualBox
3) Network -> Adapter 1 -> Advanced -> Port forwarding
4)Add new rule (little green button on right top side) and next parameters:

**************************************************************************
* Protocol       Host IP       Host Port       Guest IP       Guest Port *
* TCP            127.0.0.1     4242                           4242       *
**************************************************************************
6) In your host (physical) machine open Terminal and run
[ssh <vmusername>@localhost -p 4242]

Now you can control your virtual machine from the host terminal.

--------------------------------------------------------------------------------
CONCLUSION
--------------------------------------------------------------------------------

And after all of this manipulations we finally came for our monitoring.sh script
All guidelines is already exists in README.md file.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Dont forget to make a clone or snapshot of your VM before evaluation !
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
