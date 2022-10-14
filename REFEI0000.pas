unit REFEI0000;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TREFEI_0000 = class(TForm)
    MainMenu1: TMainMenu;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  REFEI_0000: TREFEI_0000;

implementation

{$R *.dfm}

uses REFEI0001;

procedure TREFEI_0000.BitBtn1Click(Sender: TObject);
begin
  REFEI_0001 := TREFEI_0001.Create(Self);
  REFEI_0001.ShowModal;
  REFEI_0001.Destroy;
end;

procedure TREFEI_0000.BitBtn2Click(Sender: TObject);
begin
  Halt(2)
end;

end.
