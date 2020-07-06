unit ttcHidController;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes;

type

  TDeviceType = (dtNone, dtJoystick, dtKeyboard, dtMouseAbs, dtMouseRel, dtGamepad);

  TDataEvent = procedure(const Data: Pointer; Size: Word) of object;
  TLogEvent = procedure(AMsg: string) of object;

  HIDD_ATTRIBUTES = record
    Size:          ULONG;
    VendorID:      Word;
    ProductID:     Word;
    VersionNumber: Word;
  end;
  THIDDAttributes = HIDD_ATTRIBUTES;

  TFiller = record
    {$IFDEF CPU64}
    Fill: array[0..1] of Byte;
    {$ENDIF CPU64}
  end;

  PSPDeviceInterfaceData = ^TSPDeviceInterfaceData;
  SP_DEVICE_INTERFACE_DATA = packed record
    cbSize: DWORD;
    InterfaceClassGuid: TGUID;
    Flags: DWORD;
    Reserved: ULONG_PTR;
  end;
  TSPDeviceInterfaceData = SP_DEVICE_INTERFACE_DATA;

  PSPDevInfoData = ^TSPDevInfoData;
  SP_DEVINFO_DATA = packed record
    cbSize: DWORD;
    ClassGuid: TGUID;
    DevInst: DWORD;
    Reserved: ULONG_PTR;
  end;
  TSPDevInfoData = SP_DEVINFO_DATA;

  SP_DEVICE_INTERFACE_DETAIL_DATA_W = packed record
    cbSize: DWORD;
    DevicePath: array [0..1 - 1] of WideChar;
    Filler: TFiller;
  end;
  TSPDeviceInterfaceDetailDataW = SP_DEVICE_INTERFACE_DETAIL_DATA_W;
  PSPDeviceInterfaceDetailDataW = ^TSPDeviceInterfaceDetailDataW;

  TSetupDiGetClassDevs = function(ClassGuid: PGUID; const Enumerator: PWideChar; hwndParent: HWND; Flags: DWORD): Pointer; stdcall;
  TSetupDiEnumDeviceInterfaces = function(DeviceInfoSet: Pointer; DeviceInfoData: PSPDevInfoData; const InterfaceClassGuid: TGUID;
    MemberIndex: DWORD; var DeviceInterfaceData: TSPDeviceInterfaceData): BOOL; stdcall;
  TSetupDiGetDeviceInterfaceDetailW = function(DeviceInfoSet: Pointer;
    DeviceInterfaceData: PSPDeviceInterfaceData;
    DeviceInterfaceDetailData: PSPDeviceInterfaceDetailDataW;
    DeviceInterfaceDetailDataSize: DWORD; var RequiredSize: DWORD;
    Device: PSPDevInfoData): BOOL; stdcall;
  THidD_GetHidGuid = procedure(var HidGuid: TGUID) stdcall;
  THidD_GetAttributes = function(HidDeviceObject: THandle; var HidAttrs: THIDDAttributes): LongBool; stdcall;
  THidD_GetNumInputBuffers = function(HidDeviceObject: THandle; var NumBufs: Integer): LongBool; stdcall;
  THidD_SetNumInputBuffers = function(HidDeviceObject: THandle; NumBufs: Integer): LongBool; stdcall;
  THidD_SetFeature = function(HidDeviceObject: THandle; var Report; Size: Integer): LongBool; stdcall;

const
  INVALID_HANDLE        = HINST(0);
  DIGCF_PRESENT         = $00000002;
  DIGCF_DEVICEINTERFACE = $00000010;

type
  TttcHidControllerDataReadThread = class(TThread)
  private
    FDevicePath: string;
    FHidD_SetNumInputBuffers: THidD_SetNumInputBuffers;
    FHidD_GetNumInputBuffers: THidD_GetNumInputBuffers;
    FOnData: TDataEvent;
    procedure DoData;
    procedure DoDataError;
    function CallCancelIO(Handle: THandle): Boolean;
  protected
    procedure Execute; override;
  public
    NumBytesRead: Cardinal;
    Report: array of Byte;
    constructor Create(CreateSuspended: Boolean; ADevicePath: string;
      AHidD_GetNumInputBuffers: THidD_GetNumInputBuffers; AHidD_SetNumInputBuffers: THidD_SetNumInputBuffers);
    property DevicePath: string read FDevicePath write FDevicePath;
    property HidD_SetNumInputBuffers: THidD_SetNumInputBuffers read FHidD_SetNumInputBuffers write FHidD_SetNumInputBuffers;
    property HidD_GetNumInputBuffers: THidD_GetNumInputBuffers read FHidD_GetNumInputBuffers write FHidD_GetNumInputBuffers;
    property OnData: TDataEvent read FOnData write FOnData;
  published
  end;

type ttcTHidController = class
  private
    FVendorID: Integer;
    FProductID: Integer;
    FSetupDiGetClassDevs: TSetupDiGetClassDevs;
    FSetupDiEnumDeviceInterfaces: TSetupDiEnumDeviceInterfaces;
    FSetupDiGetDeviceInterfaceDetailW: TSetupDiGetDeviceInterfaceDetailW;
    FHidD_GetHidGuid: THidD_GetHidGuid;
    FHidD_GetAttributes: THidD_GetAttributes;
    FHidGuid: TGUID;
    FHidD_GetNumInputBuffers: THidD_GetNumInputBuffers;
    FHidD_SetNumInputBuffers: THidD_SetNumInputBuffers;
    FHidD_SetFeature: THidD_SetFeature;
    FSetupHandle: HINST;
    FHIDHandle: HINST;
    FHidFileHandle: THandle;
    FHidWriteFileHandle: THandle;
    FReadThread: TttcHidControllerDataReadThread;
    FOnData: TDataEvent;
    FConnected: Boolean;
    FDeviceType: TDeviceType;
    FOnLog: TLogEvent;
    procedure Log(AMsg: string);
    function GetModuleSymbolEx(Module: HINST; SymbolName: string; var Accu: Boolean): Pointer;
    procedure OnThreadTerminated(Sender: TObject);
    procedure SetDeviceType(const Value: TDeviceType);
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadLibs;
    procedure UnloadLibs;
    function Connect: Boolean;
    procedure Disconnect;
    function SendData(var Report; const Size: Integer): Boolean;
  published
    property DeviceType: TDeviceType read FDeviceType write SetDeviceType;
    property Connected: Boolean read FConnected write FConnected;
    property VendorID: Integer read FVendorID write FVendorID;
    property ProductID: Integer read FProductID write FProductID;
    property OnData: TDataEvent read FOnData write FOnData;
    property OnLog: TLogEvent read FOnLog write FOnLog;
end;


implementation

function ReadFileEx(hFile: THandle; var Buffer; nNumberOfBytesToRead: DWORD;
  var Overlapped: TOverlapped; lpCompletionRoutine: TPROverlappedCompletionRoutine): BOOL; stdcall;
  external kernel32 name 'ReadFileEx';


function ttcTHidController.GetModuleSymbolEx(Module: HINST; SymbolName: string; var Accu: Boolean): Pointer;
begin
  Result := nil;
  if Module <> INVALID_HANDLE then
    Result := GetProcAddress(Module, PChar(SymbolName));
  Accu := Accu and (Result <> nil);
end;

{ ttcTHidController }

constructor ttcTHidController.Create;
begin
  inherited;
  FConnected := False;
  FDeviceType := dtNone;
  FReadThread := nil;
  FOnData := nil;
  FOnLog := nil;
end;

destructor ttcTHidController.Destroy;
begin
  Disconnect;
  UnloadLibs;
  inherited;
end;

procedure ttcTHidController.LoadLibs;
var
Res: Boolean;
begin
  //setupapi dll
  FSetupHandle := SafeLoadLibrary(PChar('SetupApi.dll'));
  if FSetupHandle = INVALID_HANDLE then exit;
  Res := False;
  @FSetupDiGetClassDevs := GetModuleSymbolEx(FSetupHandle, 'SetupDiGetClassDevsW', Res);
  @FSetupDiEnumDeviceInterfaces := GetModuleSymbolEx(FSetupHandle, 'SetupDiEnumDeviceInterfaces', Res);
  @FSetupDiGetDeviceInterfaceDetailW := GetModuleSymbolEx(FSetupHandle, 'SetupDiGetDeviceInterfaceDetailW', Res);
  //hid dll
  FHIDHandle := SafeLoadLibrary(PChar('HID.dll'));
  if FHIDHandle = INVALID_HANDLE then exit;
  @FHidD_GetHidGuid := GetModuleSymbolEx(FHIDHandle, 'HidD_GetHidGuid', Res);
  FHidD_GetHidGuid(FHidGuid);
  @FHidD_GetAttributes := GetModuleSymbolEx(FHIDHandle, 'HidD_GetAttributes', Res);
  @FHidD_GetNumInputBuffers := GetModuleSymbolEx(FHIDHandle, 'HidD_GetNumInputBuffers', Res);
  @FHidD_SetNumInputBuffers := GetModuleSymbolEx(FHIDHandle, 'HidD_SetNumInputBuffers', Res);
  @FHidD_SetFeature := GetModuleSymbolEx(FHIDHandle, 'HidD_SetFeature', Res);
end;

procedure ttcTHidController.UnloadLibs;
begin
  if FSetupHandle <> INVALID_HANDLE then
  begin
    FreeLibrary(FSetupHandle);
    FSetupHandle := INVALID_HANDLE;
  end;
  if FHIDHandle <> INVALID_HANDLE then
  begin
    FreeLibrary(FHIDHandle);
    FHIDHandle := INVALID_HANDLE;
  end;
end;

procedure ttcTHidController.Log(AMsg: string);
begin
  if Assigned(FOnLog) then FOnLog(AMsg);
end;

function ttcTHidController.Connect: Boolean;
var
PnPHandle: Pointer;
bFoundIt, FHasReadWriteAccess, bFoundADevice: Boolean;
i: Integer;
DeviceInterfaceData: TSPDeviceInterfaceData;
DevData: TSPDevInfoData;
BytesReturned: DWORD;
FunctionClassDeviceData: PSPDeviceInterfaceDetailDataW;
DevicePath, LDevicePath: string;
FAttributes: THIDDAttributes;
begin
  Result := False;
  if FConnected then
  begin
    Log('Already connected...');
    exit;
  end;
  FConnected := False;
  FunctionClassDeviceData := nil;
  if FDeviceType = dtNone then
  begin
    Log('Connect: No DeviceType defined.');
    Exit;
  end;
  LoadLibs;
  PnPHandle := FSetupDiGetClassDevs(@FHidGuid, nil, 0, DIGCF_PRESENT or DIGCF_DEVICEINTERFACE);
  if PnPHandle = Pointer(INVALID_HANDLE_VALUE) then
  begin
    Log('Connect: FSetupDiGetClassDevs Failed');
    Exit;
  end;
  FHidWriteFileHandle := INVALID_HANDLE_VALUE;
  //iterate through all HID devices and find the one that matches VendorID and ProductID
  bFoundIt := False;
  i := 0;
  repeat
    DeviceInterfaceData.cbSize := SizeOf(TSPDeviceInterfaceData);
    bFoundADevice := FSetupDiEnumDeviceInterfaces(PnPHandle, nil, FHidGuid, i, DeviceInterfaceData);
    if bFoundADevice then
    begin
      DevData.cbSize := SizeOf(DevData);
      BytesReturned := 0;
      FSetupDiGetDeviceInterfaceDetailW(PnPHandle, @DeviceInterfaceData, nil, 0, BytesReturned, @DevData);
      if (BytesReturned <> 0)  then
      begin
        FunctionClassDeviceData := AllocMem(BytesReturned);
        try
          FunctionClassDeviceData^.cbSize := SizeOf(TSPDeviceInterfaceDetailDataW);
          if FSetupDiGetDeviceInterfaceDetailW(PnPHandle, @DeviceInterfaceData,
            FunctionClassDeviceData, BytesReturned, BytesReturned, @DevData) then
          begin
            SetString(DevicePath, PChar(@FunctionClassDeviceData.DevicePath), (BytesReturned - (SizeOf(FunctionClassDeviceData.cbSize) + SizeOf(FunctionClassDeviceData.DevicePath))) div SizeOf(Char));
            //https://stackoverflow.com/questions/53761417/createfile-over-usb-hid-device-fails-with- access -denied-5-since-windows-10-180
            //Start of the workaround
            if DevicePath.EndsWith ('\kbd') then
            begin
              LDevicePath := DevicePath.Remove(DevicePath.IndexOf('\kbd'));
            end
            else
              LDevicePath := DevicePath;
            //End of the workaround
            FHidFileHandle := CreateFile(PChar(LDevicePath), GENERIC_READ or GENERIC_WRITE,
              FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
            FHasReadWriteAccess := FHidFileHandle <> INVALID_HANDLE_VALUE;
            if FHasReadWriteAccess then
            begin
              if FHidFileHandle <> INVALID_HANDLE_VALUE then
              begin
                FAttributes.Size := SizeOf(THIDDAttributes);
                if not FHidD_GetAttributes(FHidFileHandle, FAttributes) then
                begin
                  Log('Connect: Cannot be identified');
                end;
              end
              else
              begin
                Log('Connect: Cannot be opened');
              end;
              if (FAttributes.VendorID = FVendorID) and (FAttributes.ProductID = FProductID) then
              begin
                bFoundIt := True;
                Result := True;
                FConnected := True;
                Log('Connected.');
                FReadThread := TttcHidControllerDataReadThread.Create(True, LDevicePath, FHidD_GetNumInputBuffers, FHidD_SetNumInputBuffers);
                FReadThread.FreeOnTerminate := False;
                FReadThread.DevicePath := LDevicePath;
                FReadThread.OnData := FOnData;
                FReadThread.OnTerminate := OnThreadTerminated;
                FReadThread.Start;
              end
              else
              begin
                if FHidFileHandle <> INVALID_HANDLE_VALUE then
                  CloseHandle(FHidFileHandle);
            end;
            end;
          end;
        finally
          if Assigned(FunctionClassDeviceData) then FreeMem(FunctionClassDeviceData);
        end;
      end;
    end;
    Inc(i);
  until not bFoundADevice or bFoundIt;
end;

procedure ttcTHidController.OnThreadTerminated(Sender: TObject);
begin
  FConnected := False;
  UnloadLibs;
end;

procedure ttcTHidController.SetDeviceType(const Value: TDeviceType);
begin
  FDeviceType := Value;
  FVendorID := $F00F;
  case FDeviceType of
    dtJoystick: FProductID := $01;
    dtMouseAbs: FProductID := $02;
    dtKeyboard: FProductID := $03;
    dtGamepad: FProductID := $04;
    dtMouseRel: FProductID := $05;
  end;
end;

procedure ttcTHidController.Disconnect;
begin
  if FConnected then
  begin
    if Assigned(FReadThread) then
    begin
      try
        FReadThread.Terminate;
        FReadThread.WaitFor;
        FReadThread.Free;
        FReadThread := nil;
        FConnected := false;
        Log('Disconnected.');
      except
       Log('Disconnect: Thread terminate error');
      end;
      FConnected := False;
    end;
  end;
end;

function ttcTHidController.SendData(var Report; const Size: Integer): Boolean;
begin
  Result := False;
  if FConnected then
    Result := FHidD_SetFeature(FHidFileHandle, Report, Size);
end;

//////////////////////////////////////////////////////////////////////////////////////
constructor TttcHidControllerDataReadThread.Create(CreateSuspended: Boolean; ADevicePath: string;
  AHidD_GetNumInputBuffers: THidD_GetNumInputBuffers; AHidD_SetNumInputBuffers: THidD_SetNumInputBuffers);
begin
  inherited Create(CreateSuspended);
  FHidD_GetNumInputBuffers := AHidD_GetNumInputBuffers;
  FHidD_SetNumInputBuffers := AHidD_SetNumInputBuffers;
end;

procedure TttcHidControllerDataReadThread.DoData;
begin
  if Assigned(FOnData) then
    FOnData(@Report[1], Length(Report) - 1);
end;

procedure TttcHidControllerDataReadThread.DoDataError;
begin

end;

procedure DummyReadCompletion(ErrorCode: DWORD; Count: DWORD; Ovl: POverlapped); stdcall;
begin
end;

procedure TttcHidControllerDataReadThread.Execute;
var
FErr, SleepRet: DWORD;
FOvlRead: TOverlapped;
HidOverlappedRead: THandle;
NumOverlappedBuffers: Integer;
begin
  SleepRet := WAIT_IO_COMPLETION;
  try
    while not Terminated do
    begin
      // read data
      SleepRet := WAIT_IO_COMPLETION;

      SetLength(Report, 36);
      FillChar(Report[0], 36, #0);
      HidOverlappedRead := INVALID_HANDLE_VALUE; //it's not open yet
      if HidOverlappedRead = INVALID_HANDLE_VALUE then // if not already opened
      begin
        HidOverlappedRead := CreateFile(PChar(FDevicePath), GENERIC_READ,
          FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
        if HidOverlappedRead <> INVALID_HANDLE_VALUE then
        begin
          if NumOverlappedBuffers <> 0 then
            FHidD_SetNumInputBuffers(HidOverlappedRead, NumOverlappedBuffers);
          FHidD_GetNumInputBuffers(HidOverlappedRead, NumOverlappedBuffers);
        end;
        FillChar(FOvlRead, SizeOf(TOverlapped), #0);
        FOvlRead.hEvent := DWORD(Self);
        if ReadFileEx(HidOverlappedRead, Report[0], 36, FOvlRead, @DummyReadCompletion) then
        begin
          // wait for read to complete
          repeat
            SleepRet := SleepEx(5, True);
          until Terminated or (SleepRet = WAIT_IO_COMPLETION);
          // show data read
          if not Terminated then
          begin
            Synchronize(DoData);
          end;
        end
        else
        begin
          FErr := GetLastError;
          Synchronize(DoDataError);
          SleepEx(5, True);
        end;
      end;

    end;
  finally
    if SleepRet <> WAIT_IO_COMPLETION then
      if HidOverlappedRead <> INVALID_HANDLE_VALUE then CallCancelIO(HidOverlappedRead);
  end;
end;

function TttcHidControllerDataReadThread.CallCancelIO(Handle: THandle): Boolean;
type
  TCancelIOFunc = function(hFile: THandle): BOOL; stdcall;
var
  hKernel: HMODULE;
  CancelIOFunc: TCancelIOFunc;
begin
  hKernel := GetModuleHandle(kernel32);
  Result := hKernel <> INVALID_HANDLE_VALUE;
  if Result then
  begin
    @CancelIOFunc := GetProcAddress(hKernel, 'CancelIO');
    if Assigned(CancelIOFunc) then
      Result := CancelIOFunc(Handle)
    else
      Result := False;
  end;
end;








end.
