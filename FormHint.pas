unit FormHint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, Menus, AppEvnts,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TForm2 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TMyHint = class(THintWindow)
  private
    activeHintText: string;
    showTimer: TTimer;
    hideTimer: TTimer;
    procedure HideTime(Sender: TObject);
    procedure ShowTime(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoActivateHint(FactiveHnitText: string);
    destructor Destroy; override;
  end;
var
  Form2: TForm2;

implementation

{$R *.dfm}
constructor TMyHint.Create(AOwner: TComponent);
begin
  inherited;

  showTimer := TTimer.Create(self);
  showTimer.Interval := Application.HintPause;

  hideTimer := TTimer.Create(self);
  hideTimer.Interval := Application.HintHidePause;
end; (*Create*)

destructor TMyHint.Destroy;
begin
  hideTimer.OnTimer := nil;
  showTimer.OnTimer := nil;
  self.ReleaseHandle;
  inherited;
end; (*Destroy*)

procedure TMyHint.DoActivateHint(FactiveHnitText: string);
begin
   //force remove of the "old" hint window
  hideTime(self);

  if (FactiveHnitText = '') then
  begin
    activeHintText := '';
    Exit;
  end;

  activeHintText := FactiveHnitText;

  showTimer.OnTimer := ShowTime;
  hideTimer.OnTimer := HideTime;
end; (*DoActivateHint*)

procedure TMyHint.ShowTime(Sender: TObject);
var
  r: TRect;
  wdth: integer;
  hght: integer;
begin
  if activeHintText <> '' then
  begin
     //position and resize
    wdth := 250;//Canvas.TextWidth(activeHintText);
    hght := 400;//Canvas.TextHeight(activeHintText);

    r.Left := Mouse.CursorPos.X + 16;
    r.Top := Mouse.CursorPos.Y + 16;
    r.Right := r.Left + wdth + 6;
    r.Bottom := r.Top + hght + 4;

    ActivateHint(r, activeHintText);
  end;

  showTimer.OnTimer := nil;
end; (*ShowTime*)

procedure TMyHint.HideTime(Sender: TObject);
begin
   //hide (destroy) hint window
  self.ReleaseHandle;
  hideTimer.OnTimer := nil;
end; (*HideTime*)
end.
