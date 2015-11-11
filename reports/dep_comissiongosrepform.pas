unit dep_comissiongosrepform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, DB, ADODB;

type
  TCompReportForm = class(TForm)
    CompReport: TQuickRep;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    Query: TADOQuery;
    DescLabel: TQRLabel;
    DirectorLabel: TQRLabel;
    MembersLabel: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel18: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    DateLabel: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel47: TQRLabel;
    procedure QRLabel18Print(sender: TObject; var Value: String);
    procedure EmptyPrint(sender: TObject; var Value: String);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CompReportForm: TCompReportForm;

implementation

uses dep_main, kern;

{$R *.dfm}

procedure TCompReportForm.QRLabel18Print(sender: TObject;
  var Value: String);
begin
Value := ' '+IntToStr(Query.RecNo);
end;

procedure TCompReportForm.EmptyPrint(sender: TObject;
  var Value: String);
begin
Value := '';
end;

procedure TCompReportForm.QRDBText3Print(sender: TObject;
  var Value: String);
begin
Value := ' '+Value;
end;

procedure TCompReportForm.QRDBText1Print(sender: TObject;
  var Value: String);
begin
Value := ' '+Value;
end;

procedure TCompReportForm.QRDBText2Print(sender: TObject;
  var Value: String);
var
val : real;
wdg : TQRDBText;
begin
val := StrToFloatDef(Value, 0);
wdg := TQRDBText(sender);
if val > MINAVG then
   wdg.Font.Style := [fsBold]
   else
   wdg.Font.Style := [];
end;

end.
