unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,System.Win.ComObj,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IBBase,System.IniFiles,
  Vcl.ComCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    edt1: TEdit;
    btn1: TButton;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    edt6: TEdit;
    edt7: TEdit;
    btn2: TButton;
    chk1: TCheckBox;
    dlgOpen1: TOpenDialog;
    con1: TFDConnection;
    fdphysfbdrvrlnk1: TFDPhysFBDriverLink;
    fdtrnsctn1: TFDTransaction;
    fdqryRead: TFDQuery;
    pb1: TProgressBar;
    btn4: TSpeedButton;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);

  private
    { Private declarations }
    function GetOMSDate(n: Byte;FAMILY : string;NAME : string;father : string;BIRTHDAY : string) : Byte;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
// Создание объекта OpenDialog - назначение на нашу переменную OpenDialog
  dlgOpen1 := TOpenDialog.Create(self);

  // Установка начального каталога, чтобы сделать его текущим
  dlgOpen1.InitialDir := GetCurrentDir;

  // Только разрешенные существующие файлы могут быть выбраны
  dlgOpen1.Options := [ofFileMustExist];

  // Разрешено выбрать только .dpr и .pas файлы
  dlgOpen1.Filter :=
    'Екселевские файлы|*.xls';

  // Выбор файлов Паскаля как стартовый тип фильтра
  dlgOpen1.FilterIndex := 1;

  // Показ диалог открытия файла
  if dlgOpen1.Execute
  then edt1.Text:= dlgOpen1.FileName
  else ShowMessage('Открытие остановлено');

  // Освобождение диалога
  dlgOpen1.Free;

end;

Function GetFIO(Str : string):string;
begin
    Str:=Trim(Str);
    Str:=AnsiLowerCase(Str);
    Str:=AnsiUpperCase(Str[1])+Copy(Str,2,Length(Str));


  Result := Str;
end;

Function TForm1.GetOMSDate(n: Byte;FAMILY:string;NAME:string;father:string;BIRTHDAY:string):Byte;
begin
// n= 1 ищем по фио и др n=2 по серии и номеру полиса

   fdqryRead.Close;
  if n = 1 then
  begin
    fdqryRead.SQL.Clear;
    fdqryRead.Params.Clear;

    fdqryRead.SQL.Add('Select * from polis where (FAMILY=:FAMILY) and (NAME=:NAME) and (FATHER=:FATHER) and (BIRTHDAY=:BIRTHDAY)');

    fdqryRead.Params.ParamByName('FAMILY').Value := AnsiUpperCase(trim(FAMILY));
    fdqryRead.Params.ParamByName('NAME').Value := AnsiUpperCase(trim(NAME));
    fdqryRead.Params.ParamByName('FATHER').Value := AnsiUpperCase(trim(father));
    fdqryRead.Params.ParamByName('BIRTHDAY').Value := AnsiUpperCase(trim(BIRTHDAY));
    fdqryRead.Open;

    if fdqryRead.RecordCount <> 0 then
        begin

          fdqryRead.First;
          Result:=1;
         end
     else
     begin
     Result:=0;
     end;



  end

   else Result := 0;
    {
  if n = 2 then
  begin
    fdqryRead.SQL.Clear;
    fdqryRead.Params.Clear;



    if trim(TBase.FieldByName('serOMS').AsString) = '' then
    begin
      fdqryRead.SQL.Add('Select FAMILY, NAME, FATHER, BIRTHDAY from polis where  (NUMBER=:num)');
      dqryRead.Params.ParamByName('num').Value := trim(TBase.FieldByName('PolisOMS').AsString);
    end
    else
    begin
      fdqryRead.SQL.Add('Select FAMILY, NAME, FATHER, BIRTHDAY from polis where (SERIA=:ser) and (NUMBER=:num)');
      fdqryRead.Params.ParamByName('num').Value := trim(TBase.FieldByName('PolisOMS').AsString);
      fdqryRead.Params.ParamByName('ser').Value := trim(TBase.FieldByName('serOMS').AsString);
    end;




    fdqryRead.Open;
    if fdqryRead.RecordCount <> 0 then
    begin

      fdqryRead.First;

      TBase.Edit;

      TBase.FieldByName('FAM').AsString := GetFIO(fdqryRead.FieldByName('FAMILY').AsString);
      TBase.FieldByName('IM').AsString := GetFIO(fdqryRead.FieldByName('NAME').AsString);
      TBase.FieldByName('OT').AsString := GetFIO(fdqryRead.FieldByName('FATHER').AsString);
      TBase.FieldByName('DR').AsDateTime := fdqryRead.FieldByName('BIRTHDAY').AsDateTime;
    end;

  end;
  fdqryRead.Close;
               }
end;


procedure TForm1.btn2Click(Sender: TObject);
var Rows, Cols, i,j,n,p: integer;
    WorkSheet,ItogWorkSheet,ItogWorkSheetNot: OLEVariant;
    FData: OLEVariant;
    MyExcel,ItogExcel: OleVariant;
    xIniFile : TIniFile;
    const ExcelApp = 'Excel.Application';

begin


pb1.StepBy(1);


 if (edt2.Text='') or (edt3.Text='') or (edt4.Text='') or (edt5.Text='') or (edt6.Text='') or (edt7.Text='') then
     begin
      ShowMessage('Заполните данные по которым искать, а также номера строчек!!! (ФИО и ДР)');
      Exit;
     end;



  fdphysfbdrvrlnk1.VendorLib :=ExtractFileDir(ParamStr(0)) +pathdelim+'fbclient' + pathdelim +'fbclient.dll';


   xIniFile := TIniFile.Create('.\config.ini');

  try
    xIniFile.ReadSectionValues('connection', con1.Params);
    try
      con1.Open();
    except
      on E: Exception do
      begin

        messageDlg(e.message,mtError,[mbOK],0);
        exit;
      end;
    end;


 finally

    xIniFile.Free;

  end;


  ItogExcel := CreateOleObject(ExcelApp);
  ItogExcel.Application.DisplayAlerts := True;
  ItogExcel.Visible := false;
  ItogExcel.Workbooks.Open(ExtractFilePath(ParamStr(0))+'Шаблоны\Найденные.xlt');
  ItogWorkSheet := ItogExcel.WorkSheets[1];
  ItogWorkSheetNot := ItogExcel.WorkSheets[2];

  MyExcel := CreateOleObject(ExcelApp);
//показывать/не показывать системные сообщения Excel (лучше не показывать)
  MyExcel.Application.DisplayAlerts := False;
  MyExcel.Visible := False;

   //открываем книгу
  MyExcel.Workbooks.Open(edt1.Text);
  //получаем активный лист
  WorkSheet := MyExcel.ActiveWorkbook.ActiveSheet;
  //определяем количество строк и столбцов таблицы

  FData := WorkSheet.UsedRange.Value;
  n := 1;
  p := 1;
  for I := StrToInt(edt6.Text) to StrToInt(edt7.Text) do
  begin
    pb1.Position:=Trunc(I*100/StrToInt(edt7.Text));
    try

      if GetOMSDate(1,
                    FData[I, StrToInt(edt2.Text)],
                    FData[I, StrToInt(edt3.Text)],
                    FData[I, StrToInt(edt4.Text)],
                    FData[I, StrToInt(edt5.Text)]) = 1 then
      begin

        ItogWorkSheet.Select();

                  //dbgrd1.SetFocus;
        if (fdqryRead.Fields[29].AsString = '450052') or (chk1.Checked) then
        begin
          n := n + 1;
          for j := 0 to 30 do
            if (j=3) or (j=4) or (j=5) then
            ItogWorkSheet.Cells[n, j + 1] := GetFIO(fdqryRead.Fields[j].AsString)
            else
            ItogWorkSheet.Cells[n, j + 1] := fdqryRead.Fields[j].AsString;

            if btn4.Down = True then
               begin
            ItogWorkSheet.Cells[n, 32] := FData[I, 7];
            ItogWorkSheet.Cells[n, 33] := FData[I, 8];
            ItogWorkSheet.Cells[n, 34] := FData[I, 9];
               end;


        end

        else
        begin
          p := p + 1;

          ItogWorkSheetNOT.Select();
          for j := 0 to 30 do
          if (j=3) or (j=4) or (j=5) then
            ItogWorkSheetNOT.Cells[p, j + 1] :=GetFIO(fdqryRead.Fields[j].AsString)
           else
            ItogWorkSheetNOT.Cells[p, j + 1] := fdqryRead.Fields[j].AsString;
                      {ItogWorkSheetNOT.Cells[p,1]:=FData[I,StrToInt(edt2.Text)];
                      ItogWorkSheetNOT.Cells[p,2]:=FData[I,StrToInt(edt3.Text)];
                      ItogWorkSheetNOT.Cells[p,3]:=FData[I,StrToInt(edt4.Text)];
                      ItogWorkSheetNOT.Cells[p,4]:=FData[I,StrToInt(edt5.Text)];    }
                      if btn4.Down = True then
               begin
            ItogWorkSheetNOT.Cells[p, 32] := FData[I, 7];
            ItogWorkSheetNOT.Cells[p, 33] := FData[I, 8];
            ItogWorkSheetNOT.Cells[p, 34] := FData[I, 9];
               end;
        end;
      end
      else
      begin
        p := p + 1;
        ItogWorkSheetNOT.Select();
        ItogWorkSheetNOT.Cells[p, 4] := FData[I, StrToInt(edt2.Text)];
        ItogWorkSheetNOT.Cells[p, 5] := FData[I, StrToInt(edt3.Text)];
        ItogWorkSheetNOT.Cells[p, 6] := FData[I, StrToInt(edt4.Text)];
        ItogWorkSheetNOT.Cells[p, 7] := FData[I, StrToInt(edt5.Text)];
         if btn4.Down = True then
               begin
        ItogWorkSheetNOT.Cells[p, 32] := FData[I, 7];
        ItogWorkSheetNOT.Cells[p, 33] := FData[I, 8];
        ItogWorkSheetNOT.Cells[p, 34] := FData[I, 9];
              end;

      end;

    except

    end;

  end;

  fdqryRead.Close;

  MyExcel.Workbooks.Close;
  MyExcel.Quit;

  ItogExcel.Visible := true;

end;

procedure TForm1.btn4Click(Sender: TObject);
begin



   if( btn4.AllowAllUp ) then
  begin
    edt2.Text:='3';
edt3.Text:='4';
edt4.Text:='5';
edt5.Text:='6';
edt6.Text:='5';
edt7.Text:='5';


    btn4.AllowAllUp := False;
    btn4.Down := True;
  end else
  begin
    btn4.AllowAllUp := True;
    btn4.Down := False;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

chk1.Checked :=False;

edt1.Text:=ExtractFileDir(ParamStr(0))+'\ОСМП_неиден.xls';
end;

end.
