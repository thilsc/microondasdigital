unit UInterfaceObserver;

interface

uses Classes;

type
  ISubject = interface;

  IObserver = interface
    ['{1560FF33-F49F-4415-A5B0-CF7ACCB14535}']
    function GetSubject: TInterfacedObject;
    procedure SetSubject(const Value: TInterfacedObject);
    property Subject: TInterfacedObject read GetSubject write SetSubject;
    procedure Update;
  end;

  ISubject = interface
    ['{A896B308-A565-4DF8-9D28-19F7E0D0FDAB}']
    procedure Attach(const Observer: IObserver);
    procedure Detach(const Observer: IObserver);
    procedure DetachAll;
    procedure Notify;
  end;

implementation

end.

