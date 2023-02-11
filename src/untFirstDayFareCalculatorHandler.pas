unit untFirstDayFareCalculatorHandler;

interface

uses untFareCalculatorHandler, untSegment;

type
  TFirstDayFareCalculatorHandler = class(TInterfacedObject, IFareCalculatorHandler)
  private
    FNext : IFareCalculatorHandler;
  public
	  function calculate(segment: TSegment): Double;
    constructor Create(next: IFareCalculatorHandler);
    class function New(next: IFareCalculatorHandler): IFareCalculatorHandler;
  End;

implementation

uses SysUtils;

{ TFirstDayFareCalculatorHandler }

function TFirstDayFareCalculatorHandler.calculate(segment: TSegment): Double;
begin
  if (segment.isFirstDay()) then
  begin
    Result := 100;
    Exit;
	end;

  if (not Assigned(Self.FNext)) then
    raise Exception.Create('Erro');

	Result := Self.FNext.calculate(segment);
end;

constructor TFirstDayFareCalculatorHandler.Create(next: IFareCalculatorHandler);
begin
  Self.FNext := next;
end;

class function TFirstDayFareCalculatorHandler.New(
  next: IFareCalculatorHandler): IFareCalculatorHandler;
begin
  Result := Self.Create(next);
end;

end.
