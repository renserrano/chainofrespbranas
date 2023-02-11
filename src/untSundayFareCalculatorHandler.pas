unit untSundayFareCalculatorHandler;

interface

uses untFareCalculatorHandler, untSegment;

type
  TSundayFareCalculatorHandler = class(TInterfacedObject, IFareCalculatorHandler)
  private
    const FARE = 2.9;
  private
    FNext : IFareCalculatorHandler;
  public
	  function calculate(segment: TSegment): Double;
    constructor Create(next: IFareCalculatorHandler);
    class function New(next: IFareCalculatorHandler): IFareCalculatorHandler;
  End;

implementation

uses SysUtils;

{ TSundayFareCalculatorHandler }

function TSundayFareCalculatorHandler.calculate(segment: TSegment): Double;
begin
  if ((not segment.isOvernight()) and (segment.isSunday)) then
  begin
    Result := segment.distance * Self.FARE;
    Exit;
	end;

  if (not Assigned(Self.FNext)) then
    raise Exception.Create('Erro');

	Result := Self.FNext.calculate(segment);
end;

constructor TSundayFareCalculatorHandler.Create(next: IFareCalculatorHandler);
begin
  Self.FNext := next;
end;

class function TSundayFareCalculatorHandler.New(
  next: IFareCalculatorHandler): IFareCalculatorHandler;
begin
  Result := Self.Create(next);
end;

end.
