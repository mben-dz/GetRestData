object dmRest: TdmRest
  OnCreate = DataModuleCreate
  Height = 226
  Width = 580
  PixelsPerInch = 144
  object RESTClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://delphi-books.com/api/b/all.json'
    Params = <>
    SynchronizedEvents = False
    Left = 116
    Top = 8
  end
  object RESTRequest: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 40
    Top = 104
  end
  object RESTResponse: TRESTResponse
    ContentType = 'application/json'
    Left = 180
    Top = 104
  end
  object RestRespDataSet: TRESTResponseDataSetAdapter
    Dataset = fdMemT_Books
    FieldDefs = <>
    Response = RESTResponse
    TypesMode = Rich
    Left = 404
    Top = 12
  end
  object fdMemT_Books: TFDMemTable
    AfterScroll = fdMemT_BooksAfterScroll
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 400
    Top = 100
    object FloatField_Booksid: TFloatField
      FieldName = 'id'
    end
    object WStr_Booksname: TWideStringField
      FieldName = 'name'
      Size = 31
    end
    object WStr_Booksurl: TWideStringField
      FieldName = 'url'
      Size = 62
    end
    object WStr_Booksthumb: TWideStringField
      FieldName = 'thumb'
      Visible = False
    end
    object WStr_Bookslang: TWideStringField
      FieldName = 'lang'
      Size = 2
    end
    object WStr_Bookspubdate: TWideStringField
      FieldName = 'pubdate'
      Size = 10
    end
  end
end
