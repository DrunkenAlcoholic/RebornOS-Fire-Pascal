unit uFunctions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Process, ProcessUtils, Dialogs, StrUtils, ComCtrls;


 // Execute Commands & Process
 Function ExecuteCommand(sCmd: string): String;
 Procedure ProcessOutput(Sender: TProcessEx; output : String);
 Procedure ProcessError(Sender:TProcessEx; {%H-}IsException:boolean);

 // Check if package is installed
 Function IsPkgInstalled(strPkgName : String):Boolean;
 // Change Themes
 Procedure ThemeChange(bDarkMode: Boolean; strColour: String = 'Green');


implementation

uses
  umain;

// Execute a command
Function ExecuteCommand(sCmd: string):String;
var
  pProc: TProcessEx;
  slOutputLines: TStringList;
  sReturnString: String
begin

  Result:= 'Error';

   try
   pProc := TProcessEx.Create(nil);
   pProc.Executable := 'bash';
   pProc.Parameters.DelimitedText := '-c "' + sCmd + '"';
   pProc.OnOutput:= @(ProcessOutput);
   pProc.Execute();

   if pProc.ExitStatus = 0 then
     begin
        OutputLines.LoadFromStream(pProc.Output);
        sReturnString := Trim(OutputLines.Text);
        Result:= sReturnString;
     end;

   except
     on E: Exception do
      Showmessage('Error with Command : ' + E.message);
     end;

   finally
     pProc.Free;
     OutputLines.Free;
   end;
end;

procedure ProcessOutput(Sender: TProcessEx; output: String);
begin
    Form1.edtStat.Text:= output;
end;

procedure ProcessError(Sender: TProcessEx; IsException: boolean);
begin
    Form1.edtStat.Text:= ('Error ! ' + Sender.ExceptionInfo);
end;


// Use pacman to see if package is installed
function IsPkgInstalled(strPkgName: String): Boolean;
begin
    Result:= False;
   // if ExecuteCommand(Format('pacman -Qi %s', [strPkgName])) <> 'Error' then
     Result:= True;
end;


// Set Theme colours using Minty-Y themes, if no value for strColour is given then set to "Green" which forces default
procedure ThemeChange(bDarkMode: Boolean; strColour: String = 'Green');
var
  strWM, strTheme: string;
begin
  //Check if Dark Mode is enabled
  if bDarkMode then
    strWM := 'Mint-Y-Dark'
  else
    strWM := 'Mint-Y';

  strTheme := strWM;

  //Set theme colour if colour is different from "Green"
  if AnsiProperCase(strColour, []) <> 'Green' then
    strTheme := Format(strWM + '-%s', [AnsiProperCase(strColour, [])]);

  // Set Dark or light mode - Controls
  ExecuteCommand(Format('gsettings set org.cinnamon.desktop.interface gtk-theme %s', [strTheme]));
  //Set Icon Theme
  ExecuteCommand(Format('gsettings set org.cinnamon.desktop.interface icon-theme %s', [strTheme]));
  // Set cinnamon theme - Desktop Theme
  ExecuteCommand(Format('gsettings set org.cinnamon.theme name %s', [strTheme]));
  // set WM theme - Window Borders
  ExecuteCommand(Format('gsettings set org.cinnamon.desktop.wm.preferences theme %s', [strWM]));

end;

end.

