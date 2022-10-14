unit DlgPesquisaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, DataModule;

type
  TDlg_PesquisaCliente = class(TForm)
    dbgrd1: TDBGrid;
    RG_Situacao: TRadioGroup;
    RG_Ordem: TRadioGroup;
    EdPesq: TEdit;
    CB_Pesquisa: TComboBox;
    label60: TLabel;
    Panel2: TPanel;
    Rg_Tipo: TRadioGroup;
    Lbl_QtdeReg: TLabel;
    function  Mascara(edt: String;str:String):string;
    Procedure PesquisaRegistro;
    procedure EdPesqChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure RG_SituacaoClick(Sender: TObject);
    procedure RG_OrdemClick(Sender: TObject);
    procedure CB_PesquisaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dlg_PesquisaCliente: TDlg_PesquisaCliente;

implementation

{$R *.dfm}


function TDlg_PesquisaCliente.Mascara(edt: String;str:String):string;
var
  i : integer;
begin
  for i := 1 to Length(edt) do
  begin
     if (str[i] = '9') and not (edt[i] in ['0'..'9']) and (Length(edt)=Length(str)+1) then
        delete(edt,i,1);
     if (str[i] <> '9') and (edt[i] in ['0'..'9']) then
        insert(str[i],edt, i);
  end;
  result := edt;
end;

Procedure TDlg_PesquisaCliente.PesquisaRegistro;
Begin
  with dm.ADO_PesCliente , sql do
   begin
     close;
     clear;
     add('SELECT * FROM TesteClientes.dbo.CLIENTES');
     add('WHERE COD_CLIENTE IS NOT NULL');
     case CB_Pesquisa.ItemIndex of
       0:begin
         add('AND COD_CLIENTE LIKE '+QuotedStr('%'+EdPesq.Text+'%'));;
       end;
       1:begin
         add('AND NOME LIKE '+QuotedStr('%'+EdPesq.Text+'%'));
       end;

     end;
       case RG_Situacao.ItemIndex of
       1:begin
         add('AND SITUACAO = 0');
       end;
       2:begin
         add('AND SITUACAO = 1');
       end;

     end;
       case Rg_Tipo.ItemIndex of
       0:begin
         add('AND TIPO_PESSOA = '''+'F'+'''');
       end;
       1:begin
         add('AND TIPO_PESSOA = '''+'J'+'''');
       end;
     end;
      case RG_Ordem.ItemIndex of
       0:begin
         add('ORDER BY COD_CLIENTE ASC');
       end;
       1:begin
         add('ORDER BY NOME ASC');
       end;

     end;
       Open;
   end;
    dm.ADO_PesCliente.First;

    Lbl_QtdeReg.Caption := 'Qtde Registros: ' + Format('%5.5d',[dm.ADO_PesCliente.RecordCount]);

End;
procedure TDlg_PesquisaCliente.RG_OrdemClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TDlg_PesquisaCliente.RG_SituacaoClick(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TDlg_PesquisaCliente.CB_PesquisaChange(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TDlg_PesquisaCliente.dbgrd1DblClick(Sender: TObject);
begin
   dm.DS_Clientes.DataSet.Locate('COD_CLIENTE',dm.ADO_PesCliente.FieldByName('COD_CLIENTE').AsString,[]);
   Close;
end;

procedure TDlg_PesquisaCliente.EdPesqChange(Sender: TObject);
begin
  PesquisaRegistro;
end;

procedure TDlg_PesquisaCliente.FormShow(Sender: TObject);
begin
  PesquisaRegistro;
end;

end.
