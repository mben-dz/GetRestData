program GetRestData;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main.View in 'Main.View.pas' {MainView},
  dm.Rest in 'API\DM\dm.Rest.pas' {dmRest: TDataModule};

{$R *.res}

var
  MainView: TMainView;
begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.CreateForm(TdmRest, dmRest);
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
