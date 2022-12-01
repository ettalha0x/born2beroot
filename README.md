
# Born2BeRoot

*************
# Guide.txt #
*************

  Guide how to correctly setup and configure both Debian and software.
 
************************
# monitoring.sh script #
************************

  To make this works u need to [$ chmod +x monitoring.sh]. 
  Please note that you should run script as root because journalctl won't
  work from user without sudo.

# How to use
1) First off all :
  [$ sudo crontab -e] (yep, you need sudo to make cron runnig script as root).
  [$ crontab -e] will open another file that will run your script as user).
2) add next lines in your crontab file:
  *********************************************
  @reboot /path/to/file/monitoring.sh
  */10 * * * * /path/to/file/monitoring.sh
  *********************************************
  Dont forget that you should write FULL PATH TO FILE (no ~/*/etc.) due to cron's pecularity.
  
*********************
# evalknowledge.txt #
*********************

  Little Q&A from Subject and whattocheck as evaluator.
