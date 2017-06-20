;=====================================================
handlerOpenInExplorer( content )
{
    if( inStr( content, "\" ) )
    {
        Run %content%
        return true
    }

    if( inStr( content, "." ) )
    {
        Run %content%
        return true
    }

    return false
}

;=======================================================

openInRemedyApplication( FormatedAR )
{
    ComObjError(false)
    RemedyApp:= ComObjActive("Remedy.User")
    IsRemedyOpen:=(RemedyApp.HasDefaultSession<>"")

    if  (!IsRemedyOpen)
    {
        Run  "aruser.exe"
        WinWait, BMC Remedy User - Issue Tracking Console (Search)    
        RemedyApp:= ComObjActive("Remedy.User")    
    }
    
    Prefix:=""
    Map:= {"FT":"EMC:Feature Tracking_Main", "RET": "EMC:Release Engineering Tracker","QMR": "EMC:QM RADAR Tracker","TSK":"EMC:Feature Tracking_Task"}

    for Key, Value in Map
    {
        if (SubStr(Clipboard,1,StrLen(Key))=Key)
        {
            FormName:=Value
            Prefix:=Key
            break
        }
    }
    
    ;000000000000123
    ;FT0000000001285
    ;RET000000000168
    ;QMR000000000001
    ;TSK000000023430
    loop, % 15-StrLen(FormatedAR)-Strlen(Prefix)
    {
        FormatedAR:="0"FormatedAR
    }
    FormatedAR:=Prefix . FormatedAR

    if ErrorLevel
    {
        MsgBox, The attempt to regex text onto the clipboard failed.
        return
    }
   
    ServerName:="arsystem.isus.emc.com"
    FormName:="EMC:Issue Tracking"
    RemedyApp.LoadForm(0,ServerName,FormName,FormatedAR, 4, -1)
}

openInRemedyBrowser( FormatedAR )
{
    Prefix:=""
    ;000000000000123
    ;FT0000000001285
    ;RET000000000168
    ;QMR000000000001
    ;TSK000000023430
    loop, % 15-StrLen(FormatedAR)-Strlen(Prefix)
    {
        FormatedAR:="0"FormatedAR
    }
    FormatedAR:=Prefix . FormatedAR

    ;run, https://arswebprd01.isus.emc.com:8443/arsys/forms/arsappprd02.isus.emc.com/EMC:Issue+Tracking/Default/?eid=%FormatedAR%
    run, http://remedytools.rtp.lab.emc.com/cgi-bin/remedy/nsgview.pl?entry=%FormatedAR%
}

#q::
	send, Password123{!}
	return
	
#w::
#SingleInstance force
SendMode Input

;============= get clipboard content =============
OrgClipboard:=Clipboard
Clipboard=
Send, {CTRLDOWN}c{CTRLUP}
ClipWait, 2
if ErrorLevel
{
    MsgBox, The attempt to copy text onto the clipboard failed.
    Goto,Exit
}

;Trim the spaces    
Clipboard=%Clipboard%

if( clipboard = "" )
{
    Goto,Exit
}

;============= url =============
if( handlerOpenInExplorer(clipboard) = true )
{
    Goto,Exit
}

;============= org chart =============

FormatedAR := RegExReplace(  Clipboard, "\D", "")
if (FormatedAR="")
{
   ;PosAt:=Instr(Clipboard,"@")
   ;~ PosComma:=Instr(Clipboard,",")
   ;~ if ( Not(PosAt>0 or PosComma>0))
   ;~ {
        ;~ run,http://www.google.com/search?q=%Clipboard%
        ;~ Goto, Exit
   ;~ }
   PreEmail:=Clipboard
   PosLTBracket:=Instr(Clipboard,"<")
   if (PosLTBracket>0)
   {
      PreEmail:=Trim(SubStr(Clipboard,1,PosLTBracket-1))
   }
   ;Trim spaces
   PreEmail=%PreEmail%
   PreEmail:=Trim(PreEmail,",;:  '""")
    ;Sable, Pravin   
   run,http://NASDashboard.rtp.lab.emc.com/Outlook/OutlookActions.aspx?TEXT=%PreEmail%&ActionID=2
   Goto,Exit
}

;============= rally =============

if (RegExMatch(Clipboard,"(US\d+)",RallyAR)>0 or RegExMatch(Clipboard,"(TA\d+)",RallyAR)>0 )
{
;US60764
;TA91681    
   run,https://rally1.rallydev.com/#/search?keywords=%RallyAR%
   Goto,Exit
}


;============= remedy =============
openInRemedyBrowser( FormatedAR )

Exit:
;Restore clipboard
Clipboard :=OrgClipboard
ClipWait, 2

