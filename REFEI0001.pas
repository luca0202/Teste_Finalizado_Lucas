unit REFEI0001;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.ComCtrls, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc,
  IdBaseComponent, IdComponent, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, Vcl.DBCtrls,db, Vcl.Grids, Vcl.DBGrids,System.Math;

type
  TREFEI_0001 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Lbl_Nome: TLabel;
    Label1: TLabel;
    Lbl_Tipo: TLabel;
    Lbl_doc: TLabel;
    Lbl_doc2: TLabel;
    CB_TPessoa: TComboBox;
    Meedit_Doc1: TMaskEdit;
    Meedit_Doc2: TMaskEdit;
    TabSheet2: TTabSheet;
    RG_situacao: TRadioGroup;
    Label5: TLabel;
    btnCEP: TBitBtn;
    Meedit_Cep: TMaskEdit;
    SSLIO: TIdSSLIOHandlerSocketOpenSSL;
    XMLDocument1: TXMLDocument;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel4: TPanel;
    Bbtn_Incluir: TBitBtn;
    Bbtn_Excluir: TBitBtn;
    Bbtn_Alterar: TBitBtn;
    Bbtn_Cancelar: TBitBtn;
    Bbtn_Gravar: TBitBtn;
    Bbtn_Pesquisa: TBitBtn;
    Bbtn_Sair: TBitBtn;
    Panel2: TPanel;
    DBEdit_Cod: TDBEdit;
    DBEdit_Nome: TDBEdit;
    Edit_Bairro: TEdit;
    Edit_Cidade: TEdit;
    Edit_UF: TEdit;
    Meedit_Comp: TDBEdit;
    Meedit_Nro: TDBEdit;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    dbgrd1: TDBGrid;
    Label10: TLabel;
    RG_TipoFone: TRadioGroup;
    Bbtn_inclT: TBitBtn;
    Bbtn_AltT: TBitBtn;
    Bbtn_CancelT: TBitBtn;
    Bbtn_ExclT: TBitBtn;
    MEEdit_CelFone: TMaskEdit;
    Meedit_End: TEdit;
    Btn_GravarCT: TBitBtn;
    procedure PesquisaRegistroCELL;
    Procedure PesquisaRegistro;
    procedure ConsultaCEP(Cep: String);
    procedure btnCEPClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Bbtn_SairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Bbtn_IncluirClick(Sender: TObject);
    procedure Bbtn_AlterarClick(Sender: TObject);
    procedure Bbtn_CancelarClick(Sender: TObject);
    procedure Bbtn_GravarClick(Sender: TObject);
    procedure Bbtn_PesquisaClick(Sender: TObject);
    procedure CB_TPessoaChange(Sender: TObject);
    procedure Meedit_Doc1Exit(Sender: TObject);
    procedure Meedit_Doc1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Meedit_Doc2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RG_TipoFoneClick(Sender: TObject);
    procedure Bbtn_inclTClick(Sender: TObject);
    procedure Bbtn_AltTClick(Sender: TObject);
    procedure Bbtn_CancelTClick(Sender: TObject);
    procedure Bbtn_ExcluirClick(Sender: TObject);
    procedure Bbtn_ExclTClick(Sender: TObject);
    procedure Btn_GravarCTClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  REFEI_0001: TREFEI_0001;

implementation

{$R *.dfm}

uses DataModule, DlgPesquisaCliente;

function IsValidCNPJ(pCNPJ : string) : Boolean;
var
  v: array[1..2] of Word;
  cnpj: array[1..14] of Byte;
  I: Byte;
begin
  Result := False;

  { Verificando se tem 11 caracteres }
  if Length(pCNPJ) <> 14 then
  begin
    Exit;
  end;

  { Conferindo se todos dígitos são iguais }
  if pCNPJ = StringOfChar('0', 14) then
    Exit;

  if pCNPJ = StringOfChar('1', 14) then
    Exit;

  if pCNPJ = StringOfChar('2', 14) then
    Exit;

  if pCNPJ = StringOfChar('3', 14) then
    Exit;

  if pCNPJ = StringOfChar('4', 14) then
    Exit;

  if pCNPJ = StringOfChar('5', 14) then
    Exit;

  if pCNPJ = StringOfChar('6', 14) then
    Exit;

  if pCNPJ = StringOfChar('7', 14) then
    Exit;

  if pCNPJ = StringOfChar('8', 14) then
    Exit;

  if pCNPJ = StringOfChar('9', 14) then
    Exit;

  try
    for I := 1 to 14 do
      cnpj[i] := StrToInt(pCNPJ[i]);

    //Nota: Calcula o primeiro dígito de verificação.
    v[1] := 5*cnpj[1] + 4*cnpj[2]  + 3*cnpj[3]  + 2*cnpj[4];
    v[1] := v[1] + 9*cnpj[5] + 8*cnpj[6]  + 7*cnpj[7]  + 6*cnpj[8];
    v[1] := v[1] + 5*cnpj[9] + 4*cnpj[10] + 3*cnpj[11] + 2*cnpj[12];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);

    //Nota: Calcula o segundo dígito de verificação.
    v[2] := 6*cnpj[1] + 5*cnpj[2]  + 4*cnpj[3]  + 3*cnpj[4];
    v[2] := v[2] + 2*cnpj[5] + 9*cnpj[6]  + 8*cnpj[7]  + 7*cnpj[8];
    v[2] := v[2] + 6*cnpj[9] + 5*cnpj[10] + 4*cnpj[11] + 3*cnpj[12];
    v[2] := v[2] + 2*v[1];
    v[2] := 11 - v[2] mod 11;
    v[2] := IfThen(v[2] >= 10, 0, v[2]);

    //Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result := ((v[1] = cnpj[13]) and (v[2] = cnpj[14]));
  except on E: Exception do
    Result := False;
  end;
end;

function IsValidCPF(pCPF: string): Boolean;
var
  v: array [0 .. 1] of Word;
  cpf: array [0 .. 10] of Byte;
  I: Byte;
begin
  Result := False;

  { Verificando se tem 11 caracteres }
  if Length(pCPF) <> 11 then
  begin
    Exit;
  end;

  { Conferindo se todos dígitos são iguais }
  if pCPF = StringOfChar('0', 11) then
    Exit;

  if pCPF = StringOfChar('1', 11) then
    Exit;

  if pCPF = StringOfChar('2', 11) then
    Exit;

  if pCPF = StringOfChar('3', 11) then
    Exit;

  if pCPF = StringOfChar('4', 11) then
    Exit;

  if pCPF = StringOfChar('5', 11) then
    Exit;

  if pCPF = StringOfChar('6', 11) then
    Exit;

  if pCPF = StringOfChar('7', 11) then
    Exit;

  if pCPF = StringOfChar('8', 11) then
    Exit;

  if pCPF = StringOfChar('9', 11) then
    Exit;

  try
    for I := 1 to 11 do
      cpf[I - 1] := StrToInt(pCPF[I]);
    // Nota: Calcula o primeiro dígito de verificação.
    v[0] := 10 * cpf[0] + 9 * cpf[1] + 8 * cpf[2];
    v[0] := v[0] + 7 * cpf[3] + 6 * cpf[4] + 5 * cpf[5];
    v[0] := v[0] + 4 * cpf[6] + 3 * cpf[7] + 2 * cpf[8];
    v[0] := 11 - v[0] mod 11;
    v[0] := IfThen(v[0] >= 10, 0, v[0]);
    // Nota: Calcula o segundo dígito de verificação.
    v[1] := 11 * cpf[0] + 10 * cpf[1] + 9 * cpf[2];
    v[1] := v[1] + 8 * cpf[3] + 7 * cpf[4] + 6 * cpf[5];
    v[1] := v[1] + 5 * cpf[6] + 4 * cpf[7] + 3 * cpf[8];
    v[1] := v[1] + 2 * v[0];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);
    // Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result := ((v[0] = cpf[9]) and (v[1] = cpf[10]));
  except
    on E: Exception do
      Result := False;
  end;
end;
procedure TREFEI_0001.PesquisaRegistroCELL;
begin
  //
  with dm.ADO_PesquisaCELL,sql do
  begin
    close;
    clear;
    add('SELECT *   FROM [TesteClientes].[dbo].[TELEFONES] WHERE FK_COD_CLIENTE =:WCOD');
    Parameters.ParamByName('WCOD').Value :=  DBEdit_Cod.Text;
    open;
  end;

end;
procedure TREFEI_0001.PesquisaRegistro;
begin
  //Pesquisar no banco o Cliente para passar os dados para os EDits e Maskedit
  with dm.ADO_Pesquisa,sql do
  begin
    close;
    clear;
    add('SELECT * FROM [TesteClientes].[dbo].[CLIENTES] WHERE COD_CLIENTE =:Wcod');
    Parameters.ParamByName('Wcod').Value := DBEdit_Cod.Text;
    open;
  end;
  if  dm.ADO_Pesquisa.RecordCount > 0 then
  begin
    Meedit_Doc1.Text := dm.ADO_Pesquisa.FieldByName('DOC1').AsString;
    Meedit_Doc2.Text := dm.ADO_Pesquisa.FieldByName('DOC2').AsString;
    Meedit_End.Text  := dm.ADO_Pesquisa.FieldByName('ENDERECO').AsString;
    Meedit_Cep.Text  := dm.ADO_Pesquisa.FieldByName('CEP').AsString;
   if dm.ADO_Pesquisa.FieldByName('FK_COD_BAIRRO').AsString <> '' then
    begin
        with dm.ADO_Auxiliar,sql do
        begin
          close;
          clear;
          add('SELECT * FROM [TesteClientes].[dbo].[BAIRROS] WHERE COD_BAIRRO =:Wcod');
          Parameters.ParamByName('Wcod').Value := dm.ADO_Pesquisa.FieldByName('FK_COD_BAIRRO').AsString;
          open;
        end;
        if dm.ADO_Auxiliar.FieldByName('Descricao').AsString <> '' then    
        Edit_Bairro.Text := dm.ADO_Auxiliar.FieldByName('Descricao').AsString;

        with dm.ADO_Auxiliar2,sql do
        begin
          close;
          clear;
          add('SELECT * FROM [TesteClientes].[dbo].[CIDADES] WHERE COD_CIDADE =:Wcod');
          Parameters.ParamByName('Wcod').Value := dm.ADO_Auxiliar.FieldByName('FK_COD_CIDADE').AsString;
          open;
        end;
        if dm.ADO_Auxiliar2.FieldByName('nome').AsString <> '' then    
        Edit_Cidade.Text := dm.ADO_Auxiliar2.FieldByName('nome').AsString;
    
        with dm.ADO_Auxiliar,sql do
        begin
          close;
          clear;
          add('SELECT * FROM [TesteClientes].[dbo].[ESTADOS] WHERE COD_ESTADO =:Wcod');
          Parameters.ParamByName('Wcod').Value := dm.ADO_Auxiliar2.FieldByName('FK_COD_UF').AsString;
          open;
        end;
        if dm.ADO_Auxiliar.FieldByName('nome').AsString <> '' then
        Edit_UF.Text := dm.ADO_Auxiliar.FieldByName('nome').AsString;
    end;

  end
  else
  begin
    Meedit_Doc1.Text := '';
    Meedit_Doc2.Text := '';
    Meedit_End.Text  := '';
    Edit_Bairro.Text := '';
    Edit_Cidade.Text := '';
    Edit_UF.Text     := '';
  end;

     PesquisaRegistroCELL;
end;
procedure TREFEI_0001.RG_TipoFoneClick(Sender: TObject);
begin
  if RG_TipoFone.itemIndex = 0 then
  begin
   Bbtn_inclT.Caption  := 'Incluir Celular';
   Bbtn_AltT.Caption   := 'Alterar Celular';
   Bbtn_ExclT.Caption  := 'Excluir Celular';
   MEEdit_CelFone.EditMask := '(99)99999-9999;1;_'
  end
  else
  begin
   Bbtn_inclT.Caption  := 'Incluir Telefone';
   Bbtn_AltT.Caption   := 'Alterar Telefone';
   Bbtn_ExclT.Caption  := 'Excluir Telefone';
   MEEdit_CelFone.EditMask := '(99)9999-9999;1;_'
  end;
end;

procedure TREFEI_0001.CB_TPessoaChange(Sender: TObject);
begin
  if CB_TPessoa.ItemIndex  = 0 then
  begin
   Lbl_doc.Caption      := 'CPF';
   Lbl_doc2.Caption     := 'RG';
   Meedit_Doc1.EditMask := '999.999.999-99;1;_';
  end;
  if CB_TPessoa.ItemIndex  = 1 then
  begin
   Lbl_doc.Caption      := 'CNPJ';
   Lbl_doc2.Caption     := 'IE';
   Meedit_Doc1.EditMask := '99.999.999/9999-99;_';
  end;

end;

procedure TREFEI_0001.ConsultaCEP(Cep: String);
var
  tempXML :IXMLNode;
  tempNodePAI :IXMLNode;
  tempNodeFilho :IXMLNode;
  I :Integer;
begin
   XMLDocument1.FileName := 'https://viacep.com.br/ws/'+Trim(Cep)+ '/xml/';
   XMLDocument1.Active := true;
   tempXML := XMLDocument1.DocumentElement;


   tempNodePAI := tempXML.ChildNodes.FindNode('logradouro');

   for i := 0 to tempNodePAI.ChildNodes.Count - 1 do
   begin
      tempNodeFilho     := tempNodePAI.ChildNodes[i];
      Meedit_End.Text     :=  (UpperCase(tempNodeFilho.Text));
   end;

   tempNodePAI := tempXML.ChildNodes.FindNode('bairro');
   for i := 0 to tempNodePAI.ChildNodes.Count - 1 do
   begin
      tempNodeFilho      := tempNodePAI.ChildNodes[i];
      Edit_bairro.Text   := (UpperCase(tempNodeFilho.Text));
   end;


  tempNodePAI := tempXML.ChildNodes.FindNode('localidade');
   for i := 0 to tempNodePAI.ChildNodes.Count - 1 do
   begin
      tempNodeFilho      := tempNodePAI.ChildNodes[i];
      Edit_Cidade.Text   := (UpperCase(tempNodeFilho.Text));
   end;


  tempNodePAI := tempXML.ChildNodes.FindNode('uf');
   for i := 0 to tempNodePAI.ChildNodes.Count - 1 do
   begin
      tempNodeFilho := tempNodePAI.ChildNodes[i];
      Edit_UF.Text  := (UpperCase(tempNodeFilho.Text));
   end;


end;

procedure TREFEI_0001.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dm.ADO_Clientes.Close;
end;

procedure TREFEI_0001.FormCreate(Sender: TObject);
begin
  //********* Adicionar Tipo Pessoa ComboBox INI *************
  CB_TPessoa.Clear;
  CB_TPessoa.Items.Add('Física');
  CB_TPessoa.Items.Add('Jurídica');
  CB_TPessoa.ItemIndex := 0;
  //********* Adicionar Tipo Pessoa ComboBox FIM *************


  Lbl_doc.Caption      := 'CPF';
  Lbl_doc2.Caption     := 'RG';
  Meedit_Doc1.EditMask := '999.999.999-99;1;_';
end;

procedure TREFEI_0001.FormShow(Sender: TObject);
begin
  dm.ADO_Clientes.Open;
  dm.ADO_CELFON.Open;
  dm.ADO_Estado.Open;
  dm.ADO_Cidades.Open;
  dm.ADO_BAIRRO.Open;
  if dm.ADO_Clientes.FieldByName('Nome').AsString <> '' then
  begin
    PesquisaRegistro;
  end;
end;

procedure TREFEI_0001.Meedit_Doc1Exit(Sender: TObject);
Var SDoc : String;
begin
  if Bbtn_Incluir.Enabled = false then
  begin
    if Meedit_Doc1.Text <> '   .   .   -  ' then
    begin
    // Verifica se já tem alguem cadastrado com cpf ou Cnpj
     if CB_TPessoa.ItemIndex = 0 then
     begin
       SDoc := Copy(Meedit_Doc1.Text,1,3) + Copy(Meedit_Doc1.Text,5,3) +
               Copy(Meedit_Doc1.Text,9,3) + Copy(Meedit_Doc1.Text,13,2);
       if not IsValidCPF(SDoc) then
       begin
        ShowMessage('O CPF não é válido.');
        Meedit_Doc1.SetFocus;
        exit;
       end;
     end
     else
     begin
       SDoc := Copy(Meedit_Doc1.Text,1,2) + Copy(Meedit_Doc1.Text,4,3) +
               Copy(Meedit_Doc1.Text,8,3) + Copy(Meedit_Doc1.Text,12,4)+
               Copy(Meedit_Doc1.Text,17,2);
       if not IsValidCNPJ(SDoc) then
       begin
        ShowMessage('O CNPJ não é válido.');
        Meedit_Doc1.SetFocus;
        exit;
       end;
     end;



      with dm.ADO_Pesquisa,sql do
       begin
         Close;
         clear;
         add('SELECT DOC1 FROM [TesteClientes].[dbo].[CLIENTES]');
         add('WHERE DOC1 =:WDOC');
         Parameters.ParamByName('WDOC').Value := Meedit_Doc1.Text;
         open;
       end;
       if dm.ADO_Pesquisa.RecordCount > 0 then
       begin
         ShowMessage('Cliente já cadastrado!!');
         dm.ADO_Clientes.Cancel;
         dm.ADO_Clientes.Locate('DOC1',Meedit_Doc1.Text,[loCaseInsensitive, loPartialKey]);
         PesquisaRegistro;
         Bbtn_Cancelar.Click;
       end;


    end;

  end;
end;

procedure TREFEI_0001.Meedit_Doc1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  Meedit_Doc2.SetFocus;
end;

procedure TREFEI_0001.Meedit_Doc2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  DBEdit_Nome.SetFocus;

end;

procedure TREFEI_0001.Bbtn_AlterarClick(Sender: TObject);
begin

  Bbtn_Incluir.Enabled  := false;
  Bbtn_Alterar.Enabled  := false;
  Bbtn_Excluir.Enabled  := false;
  Bbtn_Cancelar.Enabled := true;
  Bbtn_Gravar.Enabled   := true;
  Bbtn_Pesquisa.Enabled := false;
  Bbtn_Sair.Enabled     := false;

  CB_TPessoa.Enabled    := true;
  RG_situacao.Enabled   := true;

  Meedit_Doc1.ReadOnly  := False;
  Meedit_Doc2.ReadOnly  := False;
  DBEdit_Nome.ReadOnly  := False;
  Meedit_Cep.ReadOnly   := False;
  MEEdit_Nro.ReadOnly   := False;
  MEEdit_Comp.ReadOnly  := False;
  Edit_Bairro.ReadOnly  := False;
  Edit_Cidade.ReadOnly  := False;
  Edit_UF.ReadOnly      := False;

  dm.ADO_Clientes.Edit;
end;

procedure TREFEI_0001.Bbtn_AltTClick(Sender: TObject);
begin
  dm.ADO_CELFON.Locate('COD_TELEFONE',dm.ADO_PesquisaCELL.FieldByName('COD_TELEFONE').AsString,[loCaseInsensitive, loPartialKey]);
  Bbtn_inclT.Enabled     := false;
  Bbtn_AltT.Enabled      := false;
  Bbtn_CancelT.Enabled   := true;
  Bbtn_ExclT.Enabled     := false;
  RG_TipoFone.Enabled    := true;
  Btn_GravarCT.Enabled   := true;
  MEEdit_CelFone.enabled := true;
  dbgrd1.Enabled         := False;

  MEEdit_CelFone.ReadOnly:= false;
  if Length(dm.ADO_PesquisaCELL.FieldByName('NUMERO').AsString) = 13 then
  RG_TipoFone.ItemIndex := 1
  else
  RG_TipoFone.ItemIndex := 0;
  
  
  dm.ADO_CELFON.Edit;
  MEEdit_CelFone.Text    := dm.ADO_PesquisaCELL.FieldByName('NUMERO').AsString;
  MEEdit_CelFone.SetFocus;

end;

procedure TREFEI_0001.Bbtn_CancelarClick(Sender: TObject);
begin

  Bbtn_Incluir.Enabled  := true;
  Bbtn_Alterar.Enabled  := true;
  Bbtn_Excluir.Enabled  := true;
  Bbtn_Cancelar.Enabled := false;
  Bbtn_Gravar.Enabled   := false;
  Bbtn_Pesquisa.Enabled := true;
  Bbtn_Sair.Enabled     := true;

  CB_TPessoa.Enabled    := false;
  RG_situacao.Enabled   := false;

  Meedit_Doc1.ReadOnly  := true;
  Meedit_Doc2.ReadOnly  := true;
  DBEdit_Nome.ReadOnly  := true;
  Meedit_Cep.ReadOnly   := true;
  MEEdit_Nro.ReadOnly   := true;
  MEEdit_Comp.ReadOnly  := true;
  Edit_Bairro.ReadOnly  := true;
  Edit_Cidade.ReadOnly  := true;
  Edit_UF.ReadOnly      := true;

  dm.ADO_Clientes.cancel;
  PesquisaRegistro;
end;

procedure TREFEI_0001.Bbtn_CancelTClick(Sender: TObject);
begin
  Bbtn_inclT.Enabled     := true;
  Bbtn_AltT.Enabled      := true;
  Bbtn_CancelT.Enabled   := false;
  Bbtn_ExclT.Enabled     := true;
  RG_TipoFone.Enabled    := False;
  Btn_GravarCT.Enabled   := false;
  dbgrd1.Enabled         := true;

  MEEdit_CelFone.ReadOnly:= true;

  dm.ADO_CELFON.Cancel;
end;

procedure TREFEI_0001.Bbtn_ExclTClick(Sender: TObject);
begin
 If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes then
 begin
   dm.ADO_CELFON.Locate('COD_TELEFONE',dm.ADO_PesquisaCELL.FieldByName('COD_TELEFONE').AsString,[loCaseInsensitive, loPartialKey]);
   dm.ADO_CELFON.delete;
   MessageDlg('Registro deletado com sucesso!!',mtConfirmation,[mbOK],0);
   PesquisaRegistroCELL;
 end;
end;

procedure TREFEI_0001.Bbtn_ExcluirClick(Sender: TObject);
begin
 If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes then
 begin
  dm.ADO_Clientes.Delete;
  MessageDlg('Registro deletado com sucesso!!',mtConfirmation,[mbOK],0);
  PesquisaRegistro;
 end;

end;

procedure TREFEI_0001.Bbtn_GravarClick(Sender: TObject);
begin
  try
    if DBEdit_Nome.Text = '' then
    begin
      MessageDlg('Informe nome do Cliente',mtWarning,[mbOK],0);
      next;
    end
    else
    if Meedit_Doc1.Text = '' then
    begin
      if CB_TPessoa.ItemIndex = 0 then
      MessageDlg('Informe CPF do Cliente',mtWarning,[mbOK],0);
      if CB_TPessoa.ItemIndex = 1 then
      MessageDlg('Informe CNPJ do Cliente',mtWarning,[mbOK],0);

      next;
    end
    else
    begin
      Bbtn_Incluir.Enabled  := true;
      Bbtn_Alterar.Enabled  := true;
      Bbtn_Excluir.Enabled  := true;
      Bbtn_Cancelar.Enabled := false;
      Bbtn_Gravar.Enabled   := false;
      Bbtn_Pesquisa.Enabled := true;
      Bbtn_Sair.Enabled     := true;

      CB_TPessoa.Enabled    := false;
      RG_situacao.Enabled   := false;

      Meedit_Doc1.ReadOnly  := true;
      Meedit_Doc2.ReadOnly  := true;
      DBEdit_Nome.ReadOnly  := true;
      Meedit_Cep.ReadOnly   := true;
      MEEdit_Nro.ReadOnly   := true;
      MEEdit_Comp.ReadOnly  := true;
      Edit_Bairro.ReadOnly  := true;
      Edit_Cidade.ReadOnly  := true;
      Edit_UF.ReadOnly      := true;

       //estado
      with dm.ADO_Auxiliar,sql do
      begin
        close;
        clear;
        add('SELECT * FROM [TesteClientes].[dbo].[ESTADOS] WHERE Nome =:wDESC');
        parameters.ParamByName('wDESC').Value := Edit_UF.Text;
        open;
      end;
      if dm.ADO_Auxiliar.RecordCount = 0 then
      begin
        dm.ADO_Estado.Append;
        dm.ADO_Estado.FieldByName('Nome').AsString := Edit_UF.Text;
        dm.ADO_Estado.post;
      end
      else
      dm.ADO_Estado.Locate('COD_ESTADO',dm.ADO_Auxiliar.FieldByName('COD_ESTADO').AsString, [loCaseInsensitive, loPartialKey]);

      //cidade
       with dm.ADO_Auxiliar2,sql do
       begin
         close;
         clear;
         add('SELECT * FROM [TesteClientes].[dbo].[CIDADES] WHERE Nome =:wDESC');
         parameters.ParamByName('wDESC').Value := Edit_Cidade.Text;
         open;
       end;
       if dm.ADO_Auxiliar2.RecordCount = 0 then
       begin
        dm.ADO_Cidades.Append;
        dm.ADO_Cidades.FieldByName('FK_COD_UF').AsString := dm.ADO_Estado.FieldByName('COD_ESTADO').AsString;
        dm.ADO_Cidades.FieldByName('nome').AsString      := Edit_Cidade.Text;
        dm.ADO_Cidades.post;
       END
       else
        dm.ADO_Cidades.Locate('COD_CIDADE',dm.ADO_Auxiliar2.FieldByName('COD_CIDADE').AsString, [loCaseInsensitive, loPartialKey]);

       //BAIRRRO
       with dm.ADO_Auxiliar2,sql do
       begin
         close;
         clear;
         add('SELECT * FROM [TesteClientes].[dbo].[BAIRROS] WHERE DESCRICAO =:wDESC');
         parameters.ParamByName('wDESC').Value := Edit_Cidade.Text;
         open;
       end;
       if dm.ADO_Auxiliar2.RecordCount = 0 then
       begin
        dm.ADO_BAIRRO.Append;
        dm.ADO_BAIRRO.FieldByName('FK_COD_CIDADE').AsString      := dm.ADO_Cidades.FieldByName('COD_CIDADE').AsString;
        dm.ADO_BAIRRO.FieldByName('DESCRICAO').AsString          := Edit_Bairro.Text;
        dm.ADO_BAIRRO.post;
       END
       else
      dm.ADO_BAIRRO.Locate('COD_CIDADE',dm.ADO_Auxiliar2.FieldByName('COD_CIDADE').AsString, [loCaseInsensitive, loPartialKey]);
                                            

      dm.ADO_Clientes.FieldByName('FK_COD_BAIRRO').AsString:= dm.ADO_BAIRRO.FieldByName('COD_BAIRRO').AsString;
      dm.ADO_Clientes.FieldByName('DOC1').AsString        := Meedit_Doc1.Text;
      dm.ADO_Clientes.FieldByName('DOC2').AsString        := Meedit_Doc2.Text;
      dm.ADO_Clientes.FieldByName('CEP').AsString         := Meedit_Cep.Text;
      dm.ADO_Clientes.FieldByName('ENDERECO').AsString    := Meedit_End.Text;
      //Situacao 0 para Ativos e 1 para Inativo
      if RG_situacao.ItemIndex = 0 then
      dm.ADO_Clientes.FieldByName('Situacao').value       := 0
      else
      dm.ADO_Clientes.FieldByName('Situacao').value       := 1;

      // F para pessoa Fisica e J para Juridica
      if CB_TPessoa.ItemIndex = 0 then
      dm.ADO_Clientes.FieldByName('Tipo_PESSOA').AsString := 'F'
      else
      dm.ADO_Clientes.FieldByName('Tipo_PESSOA').AsString := 'J';

      dm.ADO_Clientes.FieldByName('DATA_INCLUSAO').AsString := DateTimeToStr(Now);

      dm.ADO_Clientes.Post;
      MessageDlg('Cadastro Realizado Com Sucesso!!!',mtConfirmation,[mbOK],0);
    end;


  Except
    on E: Exception do
    begin
      MessageDlg('Falha na gravação dos dados!!!' + #13 + E.ToString ,mtError,[mbOK],0);
    end;
  end;

end;

procedure TREFEI_0001.Bbtn_inclTClick(Sender: TObject);
begin
  dm.ADO_CELFON.open;
  Bbtn_inclT.Enabled     := false;
  Bbtn_AltT.Enabled      := false;
  Bbtn_CancelT.Enabled   := true;
  Bbtn_ExclT.Enabled     := false;
  MEEdit_CelFone.Enabled := true;
  RG_TipoFone.Enabled    := true;
  Btn_GravarCT.Enabled   := true;
  MEEdit_CelFone.ReadOnly:= false;
  dbgrd1.Enabled         := False;

  
  MEEdit_CelFone.SetFocus;

  dm.ADO_CELFON.Append;
  MEEdit_CelFone.Text := '';
end;

procedure TREFEI_0001.Bbtn_IncluirClick(Sender: TObject);
begin

  Meedit_Doc1.Text      := '';
  Meedit_Doc2.Text      := '';
  Meedit_Cep.Text       := '';
  Meedit_End.Text       := '';
  Edit_Bairro.Text      := '';
  Edit_Cidade.Text      := '';
  Edit_UF.Text          := '';
  dm.ADO_Clientes.Open;
  Bbtn_Incluir.Enabled  := false;
  Bbtn_Alterar.Enabled  := false;
  Bbtn_Excluir.Enabled  := false;
  Bbtn_Cancelar.Enabled := true;
  Bbtn_Gravar.Enabled   := true;
  Bbtn_Pesquisa.Enabled := false;
  Bbtn_Sair.Enabled     := false;

  CB_TPessoa.Enabled    := true;
  RG_situacao.Enabled   := true;

  Meedit_Doc1.ReadOnly  := False;
  Meedit_Doc2.ReadOnly  := False;
  DBEdit_Nome.ReadOnly  := False;
  Meedit_Cep.ReadOnly   := False;
  MEEdit_Nro.ReadOnly   := False;
  MEEdit_Comp.ReadOnly  := False;
  Edit_Bairro.ReadOnly  := False;
  Edit_Cidade.ReadOnly  := False;
  Edit_UF.ReadOnly      := False;

  Meedit_Doc1.SetFocus;
  dm.ADO_Clientes.Append;
end;

procedure TREFEI_0001.Bbtn_PesquisaClick(Sender: TObject);
begin
  Dlg_PesquisaCliente := TDlg_PesquisaCliente.Create(Self);
  Dlg_PesquisaCliente.ShowModal;
  Dlg_PesquisaCliente.Destroy;

  dm.ADO_Clientes.Open;
  PesquisaRegistro;
//  dm.ADO_Clientes.Lookup('COD_CLIENTE',dm.ADO_PesCliente.FieldByName('COD_CLIENTE').AsString,[]);
end;

procedure TREFEI_0001.Bbtn_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TREFEI_0001.btnCEPClick(Sender: TObject);
begin
 if Meedit_Cep.Text = '     -   ' then
   begin
     ShowMessage('adicionar um cep...');
   end
   else
     begin
       ConsultaCEP(Meedit_Cep.Text);
      Meedit_Nro.SetFocus;
     end;
end;

procedure TREFEI_0001.Btn_GravarCTClick(Sender: TObject);
begin
  Btn_GravarCT.Enabled   := false;
  Bbtn_inclT.Enabled     := true;
  Bbtn_AltT.Enabled      := true;
  Bbtn_CancelT.Enabled   := false;
  Bbtn_ExclT.Enabled     := true;
  RG_TipoFone.Enabled    := False;
  Btn_GravarCT.Enabled   := false;
  dbgrd1.Enabled         := true;

  MEEdit_CelFone.ReadOnly:= true;

  dm.ADO_CELFON.FieldByName('NUMERO').AsString         := MEEdit_CelFone.Text;
  dm.ADO_CELFON.FieldByName('FK_COD_CLIENTE').AsString := DBEdit_Cod.Text;
  dm.ADO_CELFON.Post;
  
  ShowMessage('Registro Gravado com Sucesso !!!');
  PesquisaRegistroCELL;

end;

end.
