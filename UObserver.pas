unit UObserver;

interface

uses Classes, UInterfaceObserver, Forms;

type
  TSubject = class;

  TObserver = class(TInterfacedObject, IObserver)
  private
    FSubject: TSubject;
    function GetSubject: TInterfacedObject; virtual; abstract;
    procedure SetSubject(const Value: TInterfacedObject);  virtual; abstract;
  public
    property Subject: TInterfacedObject read GetSubject write SetSubject;
    procedure Update; virtual; abstract;
  end;

  TObserverForm = class(TForm, IObserver)
  private
    FSubject: TSubject;
    function GetSubject: TInterfacedObject;
    procedure SetSubject(const Value: TInterfacedObject);
  public
    property Subject: TInterfacedObject read GetSubject write SetSubject;
    procedure Update; virtual; abstract;
  end;

  TSubject = class(TInterfacedObject, ISubject)
  public
    FObservers: TInterfaceList;
    procedure Attach(const Observer: IObserver);
    procedure Detach(const Observer: IObserver);
    procedure DetachAll;
    procedure Notify;
  end;

implementation

procedure TSubject.Attach(const Observer: IObserver);
begin
  if FObservers = nil then
    FObservers := TInterfaceList.Create;

  Observer.Subject := Self;
  FObservers.Add(Observer);
end;

procedure TSubject.Detach(const Observer: IObserver);
begin
  if (FObservers <> nil) then
  begin
    FObservers.Remove(Observer);
    if (FObservers.Count = 0) then
      FObservers := nil;
  end;
end;

procedure TSubject.DetachAll;
var
  I, k: Integer;
begin
  if FObservers <> nil then
  begin
    k := FObservers.Count;
    for I := Pred(k) downto 0 do
      Detach(IObserver(FObservers[I]));
  end;
end;

procedure TSubject.Notify;
var
  I: Integer;
begin
  if FObservers <> nil then
    for I := 0 to Pred(FObservers.Count) do
      IObserver(FObservers[I]).Update;
end;

{ TObserverForm }

function TObserverForm.GetSubject: TInterfacedObject;
begin
  Result := FSubject;
end;

procedure TObserverForm.SetSubject(const Value: TInterfacedObject);
begin
  FSubject := (Value as TSubject);
end;

end.
