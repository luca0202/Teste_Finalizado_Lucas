unit DataModule;

interface

uses
   System.SysUtils, System.Classes, Data.DB, IBX.IBQuery, IBX.IBCustomDataSet,
  IBX.IBTable, IBX.IBDatabase, Data.Win.ADODB,DateUtils,

  Provider,inifiles,Dialogs,Windows,Messages,Graphics,Controls,Forms,
  Buttons, Registry, SimpleDS,
    xmldom, Xmlxform, Data.FMTBcd, Data.SqlExpr;

type
  Tdm = class(TDataModule)
    ADOConnection: TADOConnection;
    ADO_Pesquisa: TADOQuery;
    ADO_Clientes: TADOTable;
    DS_Clientes: TDataSource;
    DS_Pesquisa: TDataSource;
    ADO_CELFON: TADOTable;
    ADO_Auxiliar: TADOQuery;
    ADO_Estado: TADOTable;
    ADO_Cidades: TADOTable;
    ADO_Auxiliar2: TADOQuery;
    ADO_BAIRRO: TADOTable;
    DataSource1: TDataSource;
    DS_PesquisaCELL: TDataSource;
    ADO_PesquisaCELL: TADOQuery;
    ADO_PesCliente: TADOQuery;
    DS_PesCliente: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    b_conexaoBanco : Boolean;
  public
    V_DriverName,Alias,V_HostName, V_Database, V_UserName, V_Password, V_BlobSize, V_ErrorResourceFile : String;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses REFEI0000;

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
var sHostName,Alias,sPassword,sLogin,slinha, stexto : String;
    TArq : TextFile;
    inifile  : TInifile;
    tslista  : TStringList;
begin
  if FileExists('C:\TESTE_LUCASMASSAFERA\TESTESISTEMA.INI') = False then
  begin
     if FileExists('C:\TESTE_LUCASMASSAFERA') = False then
     begin
       ForceDirectories('C:\TESTE_LUCASMASSAFERA');
     end;
    MessageDlg('ATENÇÃO, Primeiro Acesso irá criar os "Arquivos de Configuração". Favor Atenção as Perguntas a seguir !!',mtWarning,[mbOK],0);



    Alias := InputBox('Atenção','Digite o nome de SERVIDOR do Banco de Dados.','');
    if  Application.MessageBox('banco de dados está como Autenticação do Windows ?','Atenção',36) = MrYes then
    begin
      sLogin    := '';
      sPassword := '';
    end
    else
    begin
      sLogin     := InputBox('Atenção','Digite o Login do Banco de dados','');
      sPassword  := InputBox('Atenção','Digite a Senha do Banco de Dados!!!','');
    end;

    if (Trim(Alias) <> '') then
    begin

        AssignFile(TArq,'C:\TESTE_LUCASMASSAFERA\TESTESISTEMA.INI');
        {$I-}
        rewrite(TArq);
        {$I+}


        stexto := '[CONFIGURACAO_SISTEMA]';
        slinha := stexto;
        writeln(tArq,slinha);

        stexto := 'alias=' + Alias;
        slinha := stexto;
        writeln(tArq,slinha);

        stexto := 'DataBase=SQL Server';
        slinha := stexto;
        writeln(tArq,slinha);

        stexto := 'User_Name=' + sLogin ;
        slinha := stexto;
        writeln(tArq,slinha);

        stexto := 'Password=' + sPassword;
        slinha := stexto;
        writeln(tArq,slinha);

        CloseFile (tArq);
    end;
    if FileExists('C:\TESTE_LUCASMASSAFERA\TESTESISTEMA.INI') = False then
    begin
       MessageDlg('Arquivo de Extensão .INI Não Encontrado...' + #13 + 'Ligar Para (14) 99617 - 2676 ',mtError,[mbOK],0);
       Application.Terminate;
       Exit;
    end;
  end;

  tslista   := tstringlist.create;
  IniFile   := TIniFile.Create('C:\TESTE_LUCASMASSAFERA\TESTESISTEMA.INI');
  IniFile.ReadSectionValues('CONFIGURACAO_SISTEMA', TsLista);

  Alias                   := TsLista.Values['Alias'];
  V_Database              := tslista.values['Database'];
  V_UserName              := tslista.values['User_Name'];
  V_Password              := tslista.values['Password'];


  inifile.free;
  tslista.destroy;

  b_conexaoBanco := false;
  try
      if V_UserName = '' then
      begin
         ADOConnection.Close;
         ADOConnection.ConnectionString := '';
         ADOConnection.ConnectionString :='Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Data Source='+ Alias +';Initial Catalog=MapAcesso;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Use Encryption for Data=False;Tag with column collation when possible=False'
      end
      else
      begin
           if V_Password = '' then
           begin
             ADOConnection.Close;
             ADOConnection.ConnectionString := '';
             ADOConnection.ConnectionString := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;User ID='+ V_UserName +';Data Source='+ Alias +';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Use Encryption for Data=False;Tag with column collation when possible=False';
           end
           else
           begin
             ADOConnection.Close;
             ADOConnection.ConnectionString := '';
             ADOConnection.ConnectionString := 'Provider=SQLOLEDB.1;Password='+ V_Password +';Persist Security Info=False;User ID='+ V_UserName +';Data Source='+ Alias +';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Use Encryption for Data=False;Tag with column collation when possible=False';
           end;
      end;
       b_conexaoBanco := True;
  except
    MessageDlg('Falha na Conexão (ADO) com Banco de Dados. Favor verificar com (14) 99617 - 2676',mtError,[mbOK],0);
  end;

  if b_conexaoBanco = True then
  begin
    REFEI_0000 := TREFEI_0000.Create(Self);
    REFEI_0000.ShowModal;
    REFEI_0000.Destroy;
  end;

end;

end.
