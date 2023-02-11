unit untPeakTimeFareCalculatorHandler;

interface

uses untFareCalculatorHandler, untSegment;

type
  TPeakTimeFareCalculatorHandler = class(TInterfacedObject, IFareCalculatorHandler)
  private
    const FARE = 6;
  private
    FNext : IFareCalculatorHandler;
  public
	  function calculate(segment: TSegment): Double;
    constructor Create(next: IFareCalculatorHandler);
    class function New(next: IFareCalculatorHandler): IFareCalculatorHandler;
  End;

implementation

uses SysUtils;

{ TPeakTimeFareCalculatorHandler }

function TPeakTimeFareCalculatorHandler.calculate(segment: TSegment): Double;
begin
  if (segment.isPeakTime()) then
  begin
    Result := segment.distance * Self.FARE;
    Exit;
	end;

  if (not Assigned(Self.FNext)) then
    raise Exception.Create('Erro');

	Result := Self.FNext.calculate(segment);
end;

constructor TPeakTimeFareCalculatorHandler.Create(next: IFareCalculatorHandler);
begin
  Self.FNext := next;
end;

class function TPeakTimeFareCalculatorHandler.New(
  next: IFareCalculatorHandler): IFareCalculatorHandler;
begin
  Result := Self.Create(next);
end;

end.
