#!/bin/env python

import os
import sys
import shlex
import subprocess


#
#    Constants
#

WELCOME_STRING = """
########################################################
# Running Installation Script for Workstation          #
########################################################\n\n\n
"""
RAN_SCRIP_STRING = """\n
########################################################
# Finished running Installation Script for Workstation #
########################################################
"""
caffeineInstallScriptFile = "caffeineInstallScript.sh"
caffeineInstallScriptFileContents = """ 
#!/bin/env bash
ROOT=$(pwd)
mkdir tempGnomeExtensionsInstallFolder &&
cd tempGnomeExtensionsInstallFolder &&
rm -rf gnome-shell-extension-caffeine &&
git clone git://github.com/eonpatapon/gnome-shell-extension-caffeine.git &&
cd gnome-shell-extension-caffeine &&
./update-locale.sh &&
glib-compile-schemas --strict --targetdir=caffeine@patapon.info/schemas/ caffeine@patapon.info/schemas &&
cp -r caffeine@patapon.info ~/.local/share/gnome-shell/extensions
"""
CLEANER_FILE="clean.sh"
RUN_SCRIPT_AS_ROOT_STRING = "\n\nPlease run this script as root or equivalent.\n\n"
DNF_CONST_FILE = "/etc/dnf/dnf.conf"
DNF_DELTARPM_CONFIG_STRING = "deltarpm=1"
OS_UPDATE_SYSTEM = "sudo dnf update -y"
SUDO_GET_PASSWORD = "sudo touch /tmp/tempFileForInstallationScript"
SUDO_FORGET_PASSWORD = "sudo -k"
SUDO_FORGET_PASSWORD_STRING = "\n\nForgetting sudo password.\n\n"
INSTALL_PACKAGE_CMD = "sudo dnf install -y "
FEDORA_VERSION_NUMBER = subprocess.check_output(['rpm','-E %fedora'])
RPM_FUSION_FREE_DOWNLOAD_URL = ("\"https://download1.rpmfusion.org/free/fedora"
    "/rpmfusion-free-release-" + FEDORA_VERSION_NUMBER.strip() +
    ".noarch.rpm\"")

RPM_FUSION_NONFREE_DOWNLOAD_URL = ("\"https://download1.rpmfusion.org/nonfree"
    "/fedora/rpmfusion-nonfree-release-" + FEDORA_VERSION_NUMBER.strip() +
    ".noarch.rpm\"")
ATOM_EDITOR_DOWNLOAD_URL = "https://atom.io/download/rpm"
PACKAGES_FILE = "gnomeShell3Packages.txt"
PACKAGE_TO_INSTALL_LIST = " "
LIST_OF_FILES_TO_KEEP_AFTER_RUNNING = "filesToKeep.txt"
FILES_TO_KEEP_AFTER_RUNNING = " "
ERROR_OPENING_PACKAGES_FILE = ("\n\nPlease make sure that the file " 
        + PACKAGES_FILE + " exists.\n\n")
ERROR_OPENING_PACKAGES_TO_KEEP_FILE = ("\n\nPlease make sure that the file " 
        + LIST_OF_FILES_TO_KEEP_AFTER_RUNNING + " exists.\n\n")
ERROR_RUNNING_COMMAND = "\n\n Error running the command: "
ERROR_OPENING_FILE = "\n\n Error opening the command: "
COMMAND_GET_FILES_TO_KEEP = "cat filesToKeep.txt"
KEEP_PASSWORD = 1

#
#    Functions
#

def getListOfFilesToKeepAfterRunning():
    global FILES_TO_KEEP_AFTER_RUNNING 
    try:
        FILES_TO_KEEP_AFTER_RUNNING = subprocess.check_output(['cat',
            LIST_OF_FILES_TO_KEEP_AFTER_RUNNING])
    except:
        print(ERROR_OPENING_PACKAGES_TO_KEEP_FILE)
        exitScript(KEEP_PASSWORD)
    print("Finished getting files to keep after install.")

def writeContentsToFile(localFileToWriteTo, localContentsToWrite):
    try:
        localTempFileToWriteContents = open(localFileToWriteTo,"w") 
        localTempFileToWriteContents.write(localContentsToWrite) 
        localTempFileToWriteContents.close()
    except:
        fileNotOpenSuccessfully(localFileToWriteTo)
        exitScript(KEEP_PASSWORD)

def executeFile(localFileToRun):    
    runCommand("sh ./" + localFileToRun)

def makeFileExecutable(localFileToTurnExecutable):    
    runCommand("chmod +x " + localFileToTurnExecutable)

def runCommand(localCommandToRun):
    try:
        subprocess.call(shlex.split(localCommandToRun))
    except:
        commandNotRanSuccessfully(localCommandToRun)
        exitScript(KEEP_PASSWORD)


def fileNotOpenSuccessfully(localFileNotOpen):
    print(ERROR_OPENING_FILE + localFileNotOpen +" \n\n\n")

def commandNotRanSuccessfully(commandRan):
    print(ERROR_RUNNING_COMMAND + commandRan +" \n\n\n")

def exitScript(forgetPass):
    if(forgetPass == 0):
        makeSudoForgetPass()
    printEndString()
    exit()

def setDeltaRpm():
    fobj = open(DNF_CONST_FILE)
    dnfConfFile = fobj.read().strip().split()
    stringToSearch = DNF_DELTARPM_CONFIG_STRING 
    if stringToSearch in dnfConfFile:
        print("Delta rpm already configured.\n")
    else: 
    	print('Setting delta rpm...\n')
        fobj.close()
        commandToRun = "sudo sh -c 'echo " + DNF_DELTARPM_CONFIG_STRING + " >> " + DNF_CONST_FILE +"'"
        runCommand(commandToRun)

def performUpdate():
    print("\nUpdating system...\n")
    runCommand(OS_UPDATE_SYSTEM)
    print("\nUpdated system.\n")

def performInstallFirstStage():
    setDeltaRpm() 

def installPackage(localPackageToInstall):
    commandToRun = INSTALL_PACKAGE_CMD + localPackageToInstall
    runCommand(commandToRun)

def installRpmFusion():
    print("\nInstalling rpmfusion...\n")
    installPackage(RPM_FUSION_FREE_DOWNLOAD_URL)
    installPackage(RPM_FUSION_NONFREE_DOWNLOAD_URL)
    print("\nInstaled rpmfusion.\n")

def installAtomEditor():
    print("\nInstalling Atom editor...\n")
    installPackage(ATOM_EDITOR_DOWNLOAD_URL)
    print("\nInstaled Atom editor.\n")

def getListOfPackagesToInstall():
    print("Getting list of packages to install from " + PACKAGES_FILE + " ...")
    global PACKAGE_TO_INSTALL_LIST 
    try:
        PACKAGE_TO_INSTALL_LIST = subprocess.check_output(['cat',PACKAGES_FILE])
    except:
        print(ERROR_OPENING_PACKAGES_FILE)
        exitScript(KEEP_PASSWORD)
    print("Finished getting package list.")

def installPackagesFromFile():
    print("Installing packages from list...")
    installPackage(PACKAGE_TO_INSTALL_LIST)
    print("Finished installing package list.")

def cleanAfterInstall():
    getListOfFilesToKeepAfterRunning()
    print(FILES_TO_KEEP_AFTER_RUNNING)


def installCaffeineGnomeExtention():
    # Caffeine Gnome Shell Extension
    print("Installing Caffeine Gnome Shell Extensions...")
    writeContentsToFile(caffeineInstallScriptFile,caffeineInstallScriptFileContents)
    makeFileExecutable(caffeineInstallScriptFile)    
    executeFile(caffeineInstallScriptFile)
    executeFile(CLEANER_FILE)
    print("Instaled Caffeine Gnome Shell Extensions.")

def performInstallFourthStage():
    installCaffeineGnomeExtention()

def performInstallThirdStage():
    getListOfPackagesToInstall()
    installPackagesFromFile()

def performInstallSecondtStage():
    installRpmFusion()
    
def performInstall():
    #performInstallFirstStage()   
    #performUpdate()
    #performInstallSecondtStage()
    #performUpdate()
    #performInstallThirdStage()
    #performInstallFourthStage()
    cleanAfterInstall()

    #
    #
    #
    #echo 'Downloading hplip and lastpass for later install...'
    #mkdir /home/jgorgulho/toInstall
    #wget -O hplip.run "http://downloads.sourceforge.net/project/hplip/hplip/3.16.11/hplip-3.16.11.run?r=http%3A%2F%2Fhplipopensource.com%2Fhplip-web%2Finstall%2Finstall%2Findex.html&ts=1480467242&use_mirror=netassist"
    #wget -O lastpass.tar.bz2 "https://lastpass.com/lplinux.tar.bz2"
    #echo 'Moving hplip and lastpass to user folder...'
    #mv hplip.run /home/jgorgulho/toInstall
    #mv lastpass.tar.bz2 /home/jgorgulho/toInstall
    #chown -R jgorgulho /home/jgorgulho/toInstall
    #chown -R jgorgulho /home/jgorgulho/toInstall/*
    #
    #echo "Cloning dotfiles from github repo to root..."
    #git clone https://github.com/jgorgulho/dotfiles /root/.dotfiles
    #ln -sf /root/.dotfiles/.bashrc /root/.bashrc
    #echo "Cloning dotfiles from github repo to user..."
    #git clone https://github.com/jgorgulho/dotfiles /home/jgorgulho/.dotfiles
    #ln -sf /home/jgorgulho/.dotfiles/.bashrc /home/jgorgulho/.bashrc
    #chown -R jgorgulho /home/jgorgulho/.dotfiles
    #chown -R jgorgulho /home/jgorgulho/.dotfiles/.*
    #chown -R jgorgulho /home/jgorgulho/.bashrc
    #
    #echo "Installing Jekyll..."
    #gem install jekyll
    #
    #echo "Enabling tuned..."
    #systemctl enable tuned
    #echo "Enabling powertop..."
    #systemctl enable powertop

def checkIfUserHasRootRights():
    return(os.geteuid())

def printWelcomeString():
    print(WELCOME_STRING)

def printNeedRootRightsString():
    print(RUN_SCRIPT_AS_ROOT_STRING)

def printEndString():
    print(RAN_SCRIP_STRING)

def getSudoPass():
    runCommand(SUDO_GET_PASSWORD)

def makeSudoForgetPass():
    print(SUDO_FORGET_PASSWORD_STRING)
    runCommand(SUDO_FORGET_PASSWORD)

def main():    
    printWelcomeString()
    if(checkIfUserHasRootRights() == 0):
        performInstall()
    else:
        try:
            getSudoPass()
        except:
            printNeedRootRightsString()
            exitScript(KEEP_PASSWORD)
        performInstall()
    exitScript(KEEP_PASSWORD)

#
# Run Main Script
#

main()

