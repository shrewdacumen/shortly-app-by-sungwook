#  The Problem I faced

## Problem 1. the starbucks network caused a problem.
Sep 02, Thursday 
I tried to execute the command on terminal. (I’m accustomed to use git on terminal)

But all failed.
I think this may be caused by the Wi-fi environment of Startbucks.
The following message had me think twice.

## Problem 2.
Even after I solve the problem,
```
    git clone http://berbob-gmbh-tdcedi@git.codesubmit.io/berbob-gmbh/shortly-app-swiftui-fmlzpw
```
The above command line does not solve the problem but the following did
```  
    sudo git clone http://berbob-gmbh-tdcedi@git.codesubmit.io/berbob-gmbh/shortly-app-swiftui-fmlzpw
```

The problem is some of .git files keep turning into files owned by root.


## Problem 3.
I'm using Swift3, the latest one.
in order to maximize the ability I have to use Xcode 13 beta 5.
However, for the compatibility I had to lower the version to Xcode 12.

The problem is that On Xcode 12 Info.plist is continually giving me a strange error that is not acutally error:
  It compiles well and test well, but gives a false error.
However, On Xcode 13, I have no such issue: I have no choice because I should stick to Xcode 12 to make my project accessible by the company.


