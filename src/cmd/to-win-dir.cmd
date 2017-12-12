:: File:ToWindowsDir.cmd v.0.1.0 docs at the end
perl -e "use Win32::Clipboard ; $CLIP = Win32::Clipboard();$NEWCLIP=$CLIP->Get();$NEWCLIP=~s/(^\/vagrant)|(^\/var)/C:\\var/gi;$NEWCLIP=~s/\/cygdrive\/([a-zA-Z]{1})\//$1\:\\/gi;$NEWCLIP=~s/file:\/\/\///gi;$NEWCLIP=~s/\//\\/gi;$CLIP->Set($NEWCLIP);print; "
:: pause
 
 :: Purpose:
:: change any \ chars from your windows clipboard into / chars , replace c: with /cygdrive/c
:: from your clipboard 
:: Requirements : windows , perl , Win32::Clipboard module 
:: usage: place this cmd file in your path , double-click bat file or create a short cut of it , place on desktop 
:: right click the shortcut , Properties , Click on ShortCut key , press U , click ok
:: COPY some path from your explorer such as C:\Temp, Alt + U , paste in cygwin as /cygwin/c/Temp
:: VersionHistory
:: 0.1.0 -- ysg -- Initial creation{\rtf1}