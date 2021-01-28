unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, ECSwitch;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    edtStat: TEdit;
    GroupBox1: TGroupBox;
    gbLibrewolf: TGroupBox;
    GroupBox2: TGroupBox;
    gbFirefox: TGroupBox;
    gbChromium: TGroupBox;
    gbGoogleChrome: TGroupBox;
    gbBrave: TGroupBox;
    gbFalkon: TGroupBox;
    gbOpera: TGroupBox;
    gbVivaldi: TGroupBox;
    imgFirefox: TImage;
    imgChromium: TImage;
    imgGoogleChrome: TImage;
    imgBrave: TImage;
    imgFalkon: TImage;
    imgOpera: TImage;
    imgVivaldi: TImage;
    imgLibreWolf: TImage;
    Label1: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    pgPrograms: TPageControl;
    pgctlMain: TPageControl;
    imgFIRElogo: TImage;
    pnlclrAqua: TPanel;
    pnlclrBlue: TPanel;
    pnlclrBrown: TPanel;
    pnlclrGreen: TPanel;
    pnlclrGrey: TPanel;
    pnlclrOrange: TPanel;
    pnlclrPink: TPanel;
    pnlclrPurple: TPanel;
    pnlclrRed: TPanel;
    pnlclrSand: TPanel;
    pnlclrTeal: TPanel;
    pnlSidebar: TPanel;
    pnlSidebarHeader: TPanel;
    pnlBtnCustomization: TPanel;
    pnlBtnSystemTask: TPanel;
    pnlBtnPrograms: TPanel;
    pnlBtnRollback: TPanel;
    pnlNav: TPanel;
    swt: TECSwitch;
    swt1: TECSwitch;
    swt2: TECSwitch;
    swt3: TECSwitch;
    swt4: TECSwitch;
    swt5: TECSwitch;
    swtFirefox: TECSwitch;
    swtDarkModeEnable: TECSwitch;
    swtChromium: TECSwitch;
    swtGoogleChrome: TECSwitch;
    swtBrave: TECSwitch;
    swtFalkon: TECSwitch;
    swtOpera: TECSwitch;
    swtVivaldi: TECSwitch;
    swtLibrewolf: TECSwitch;
    tsBrowsers: TTabSheet;
    tsOffice: TTabSheet;
    tsInternet: TTabSheet;
    tsCustomization: TTabSheet;
    tsSystemTasks: TTabSheet;
    tsPrograms: TTabSheet;
    tsRollBack: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pnlBtnCustomizationClick(Sender: TObject);
    procedure pnlBtnSystemTaskClick(Sender: TObject);
    procedure pnlBtnProgramsClick(Sender: TObject);
    procedure pnlBtnRollbackClick(Sender: TObject);
    procedure pnlclrClick(Sender: TObject);
    procedure pnlclrMouseEnter(Sender: TObject);
    procedure pnlclrMouseLeave(Sender: TObject);
    procedure swtDarkModeEnableClick(Sender: TObject);
    procedure swtEnter(Sender: TObject);
    procedure swtMouseEnter(Sender: TObject);
  private
  public

  end;

var
  Form1: TForm1;

implementation

uses
  uFunctions;
{$R *.lfm}

{ TForm1 }


// Remove focus from toggle switches
procedure TForm1.FormActivate(Sender: TObject);
begin
  pnlSidebar.SetFocus;

  //Check Browser that are installed
  swtFirefox.Checked := IsPkgInstalled('firefox');
  swtGoogleChrome.Checked := IsPkgInstalled('google-chrome');
  swtVivaldi.Checked := IsPkgInstalled('vivaldi');
  swtOpera.Checked := IsPkgInstalled('opera');
  swtChromium.Checked := IsPkgInstalled('chromium');
  swtBrave.Checked := IsPkgInstalled('brave');
  swtFalkon.Checked := IsPkgInstalled('falkon');
  swtLibrewolf.Checked := IsPkgInstalled('librewolf');


end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  // Just for testing ExecutCommand function
  ShowMessage(ExecuteCommand('pkexec pacman -S --noconfirm --needed code'));
  Application.ProcessMessages;
end;

// Remove focus from toggle switches
procedure TForm1.swtMouseEnter(Sender: TObject);
begin
  pnlSidebar.SetFocus;
end;

// Remove focus from toggle switches
procedure TForm1.swtEnter(Sender: TObject);
begin
  pnlSidebar.SetFocus;
end;

//==================
// Button Events
//==================

//Customization Click event
procedure TForm1.pnlBtnCustomizationClick(Sender: TObject);
begin
  // Set panel (pnlNav) to same size as button for selection affect
  pnlNav.Height := pnlBtnCustomization.Height;
  pnlNav.Top := pnlBtnCustomization.Top;
  pnlNav.Left := pnlBtnCustomization.Left;
  pnlBtnCustomization.Color := RGBToColor(46, 51, 73);

  // Set page control
  pgctlMain.ActivePage := tsCustomization;

  // Set other button colours to non selected Colours
  pnlBtnSystemTask.Color := RGBToColor(20, 30, 50);
  pnlBtnPrograms.Color := RGBToColor(20, 30, 50);
  pnlBtnRollback.Color := RGBToColor(20, 30, 50);
end;

//System Tasks Click event
procedure TForm1.pnlBtnSystemTaskClick(Sender: TObject);
begin
  // Set panel (pnlNav) to same size as button for selection affect
  pnlNav.Height := pnlBtnSystemTask.Height;
  pnlNav.Top := pnlBtnSystemTask.Top;
  pnlNav.Left := pnlBtnSystemTask.Left;
  pnlBtnSystemTask.Color := RGBToColor(46, 51, 73);

  // Set page control
  pgctlMain.ActivePage := tsSystemTasks;

  // Set other button colours to non selected Colours
  pnlBtnCustomization.Color := RGBToColor(20, 30, 50);
  pnlBtnPrograms.Color := RGBToColor(20, 30, 50);
  pnlBtnRollback.Color := RGBToColor(20, 30, 50);
end;

//PRograms Click event
procedure TForm1.pnlBtnProgramsClick(Sender: TObject);
begin
  // Set panel (pnlNav) to same size as button for selection affect
  pnlNav.Height := pnlBtnPrograms.Height;
  pnlNav.Top := pnlBtnPrograms.Top;
  pnlNav.Left := pnlBtnPrograms.Left;
  pnlBtnPrograms.Color := RGBToColor(46, 51, 73);

  // Set page control
  pgctlMain.ActivePage := tsPrograms;

  // Set other button colours to non selected Colours
  pnlBtnSystemTask.Color := RGBToColor(20, 30, 50);
  pnlBtnCustomization.Color := RGBToColor(20, 30, 50);
  pnlBtnRollback.Color := RGBToColor(20, 30, 50);
end;

//Roll Back Click event
procedure TForm1.pnlBtnRollbackClick(Sender: TObject);
begin
  // Set panel (pnlNav) to same size as button for selection affect
  pnlNav.Height := pnlBtnRollback.Height;
  pnlNav.Top := pnlBtnRollback.Top;
  pnlNav.Left := pnlBtnRollback.Left;
  pnlBtnRollback.Color := RGBToColor(46, 51, 73);

  // Set page control
  pgctlMain.ActivePage := tsRollBack;

  // Set other button colours to non selected Colours
  pnlBtnSystemTask.Color := RGBToColor(20, 30, 50);
  pnlBtnPrograms.Color := RGBToColor(20, 30, 50);
  pnlBtnCustomization.Color := RGBToColor(20, 30, 50);

end;

// Set Theme Colours and Dark Mode
procedure TForm1.pnlclrClick(Sender: TObject);
begin
  // Change theme using colour name from hint and darkmode switch on/off
  ThemeChange(swtDarkModeEnable.Checked, TPanel(Sender).Hint);

  //Refresh  Form for theme to take affect
  Form1.Refresh;
end;

// Theme Colour Effects on mouse over event
procedure TForm1.pnlclrMouseEnter(Sender: TObject);
begin
  TPanel(Sender).Height := 26;
  TPanel(Sender).Width := 26;
end;

// Theme Colour Effects on mouse leave event
procedure TForm1.pnlclrMouseLeave(Sender: TObject);
begin
  TPanel(Sender).Height := 20;
  TPanel(Sender).Width := 20;
end;

// Dark Mode Switch event
procedure TForm1.swtDarkModeEnableClick(Sender: TObject);
begin
  // darkmode switch on/off using default theme "Green"
  ThemeChange(swtDarkModeEnable.Checked);

  //Refresh  Form for theme to take affect
  Form1.Refresh;

end;

end.
