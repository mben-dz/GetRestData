unit Main.View;

interface
// Based on this video here:
// https://www.youtube.com/watch?v=UAO2wHyDDEg

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts, System.Rtti, FMX.Grid.Style, FMX.Objects,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, Data.Bind.Controls,
  Fmx.Bind.Navigator, FMX.Edit, FMX.StdCtrls;

type
  TMainView = class(TForm)
    Lyt_Root: TLayout;
    Lyt_Top: TLayout;
    Lyt_B: TLayout;
    Lyt_Toolbar: TLayout;
    GridBooks: TGrid;
    ImgBook: TImage;
    BindSrcDB: TBindSourceDB;
    BindingList: TBindingsList;
    LinkGridToDataSrc: TLinkGridToDataSource;
    BindNavigator1: TBindNavigator;
    EdtBookUrl: TEdit;
    StyleMgr: TStyleBook;
    ProgressBarThumb: TProgressBar;
    procedure FormCreate(Sender: TObject);
  private
    procedure HandleOnThumbLoaded(const aStream: TStream);
    procedure HandleOnBookUrl(const aUrl: string);

    procedure HandleOnReceiveProgress(const aBytesRead, aTotalBytes: Int64);

  end;

implementation

uses
  Data.DB,
  dm.Rest;

{$R *.fmx}

procedure TMainView.HandleOnBookUrl(const aUrl: string);
begin
  EdtBookUrl.Text := aUrl;
end;

procedure TMainView.HandleOnReceiveProgress(
  const aBytesRead, aTotalBytes: Int64);
begin
  ProgressBarThumb.Visible := True;

  if aTotalBytes > 0 then
  begin
    ProgressBarThumb.Max := aTotalBytes;
    ProgressBarThumb.Value := aBytesRead;
  end
  else
  begin
    // unknown length → use marquee style
    ProgressBarThumb.Max := 100;
    ProgressBarThumb.Value := (aBytesRead mod 100);
  end;
end;

procedure TMainView.HandleOnThumbLoaded(const aStream: TStream);
begin
  if not EdtBookUrl.Text.EndsWith('.jpg') then Exit;

  try
    ImgBook.Bitmap.LoadFromStream(aStream);
  finally
    aStream.Free;
  end;

  // hide progress bar after done
  ProgressBarThumb.Visible := False;
end;

procedure TMainView.FormCreate(Sender: TObject);
begin
  dmRest.OnThumbProgress := HandleOnReceiveProgress;
  dmRest.OnBookUrl := HandleOnBookUrl;
  dmRest.OnThumbLoaded := HandleOnThumbLoaded;

  // trigger first record manually
  if not dmRest.fdMemT_Books.IsEmpty then
    dmRest.fdMemT_BooksAfterScroll(dmRest.fdMemT_Books);
end;

end.
