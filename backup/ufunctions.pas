unit uFunctions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Process, ProcessUtils, Dialogs, StrUtils, ComCtrls;


// Execute Commands & Process
function ExecuteCommand(sCmd: string): string;
procedure ProcessOutput(Sender: TProcessEx; output: string);
procedure ProcessError(Sender: TProcessEx; {%H-}IsException: boolean);

// Check if package is installed
function IsPkgInstalled(strPkgName: string): boolean;
// Change Themes
procedure ThemeChange(bDarkMode: boolean; strColour: string = 'Green');


implementation

uses
  umain;

// Execute a command
function ExecuteCommand(sCmd: string): string;
var
  pProc: TProcessEx;
  slOutputLines: TStringList;
  sReturnString: string;
begin
  // Set return result as failed
  Result := 'Error';

  try
    try
      pProc := TProcessEx.Create(nil);
      slOutputLines := TStringList.Create;
      pProc.Executable := 'bash';
      pProc.Parameters.DelimitedText := '-c "' + sCmd + '"';
      pProc.OnOutput := @(ProcessOutput);
      pProc.Execute();

      // If exit code = 0 then it succeeded
      if pProc.ExitStatus = 0 then
      begin
        slOutputLines.LoadFromStream(pProc.Output);
        sReturnString := Trim(slOutputLines.Text);
        // Set successful result as output
        Result := sReturnString;
      end;

    except
      on E: Exception do
        ShowMessage('Error with Command : ' + E.message);

    end;

  finally
    pProc.Free;
    slOutputLines.Free;
  end;
end;

procedure ProcessOutput(Sender: TProcessEx; output: string);
begin
  Form1.edtStat.Text := output;
end;

procedure ProcessError(Sender: TProcessEx; IsException: boolean);
begin
  Form1.edtStat.Text := ('Error ! ' + Sender.ExceptionInfo);
end;


// Use pacman to see if package is installed
function IsPkgInstalled(strPkgName: string): boolean;
begin
  Result := False;
  // if ExecuteCommand(Format('pacman -Qi %s', [strPkgName])) <> 'Error' then
  Result := True;
end;


// Set Theme colours using Minty-Y themes, if no value for strColour is given then set to "Green" which forces default
procedure ThemeChange(bDarkMode: boolean; strColour: string = 'Green');
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
  ExecuteCommand(Format('gsettings set org.cinnamon.desktop.interface gtk-theme %s',
    [strTheme]));
  //Set Icon Theme
  ExecuteCommand(Format('gsettings set org.cinnamon.desktop.interface icon-theme %s',
    [strTheme]));
  // Set cinnamon theme - Desktop Theme
  ExecuteCommand(Format('gsettings set org.cinnamon.theme name %s', [strTheme]));
  // set WM theme - Window Borders
  ExecuteCommand(Format('gsettings set org.cinnamon.desktop.wm.preferences theme %s',
    [strWM]));

end;

end.
