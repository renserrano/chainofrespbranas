unit untOvernightSundayFareCalculatorHandler;

interface

uses untFareCalculatorHandler, untSegment;

type
  TOvernightSundayFareCalculatorHandler = class(TInterfacedObject, IFareCalculatorHandler)
  private
    const FARE = 5;
  private
    FNext : IFareCalculatorHandler;
  public
	  function calculate(segment: TSegment): Double;
    constructor Create(next: IFareCalculatorHandler);
    class function New(next: IFareCalculatorHandler): IFareCalculatorHandler;
  End;

implementation

uses SysUtils;

{ TOvernightSundayFareCalculatorHandler }

function TOvernightSundayFareCalculatorHandler.calculate(
  segment: TSegment): Double;
begin
  if ((segment.isOvernight()) and (segment.isSunday())) then
  begin
    Result := segment.distance * Self.FARE;
    Exit;
	end;

  if (not Assigned(Self.FNext)) then
    raise Exception.Create('Erro');

	Result := Self.FNext.calculate(segment);
end;

constructor TOvernightSundayFareCalculatorHandler.Create(
  next: IFareCalculatorHandler);
begin
  Self.FNext := next;
end;

class function TOvernightSundayFareCalculatorHandler.New(
  next: IFareCalculatorHandler): IFareCalculatorHandler;
begin
  Result := Self.Create(next)
end;

end.
