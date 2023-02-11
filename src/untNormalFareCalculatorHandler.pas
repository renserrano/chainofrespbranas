unit untNormalFareCalculatorHandler;

interface

uses untFareCalculatorHandler, untSegment;

type
  TNormalFareCalculatorHandler = class(TInterfacedObject, IFareCalculatorHandler)
  private
    const FARE = 2.1;
  private
    FNext : IFareCalculatorHandler;
  public
	  function calculate(segment: TSegment): Double;
    constructor Create(next: IFareCalculatorHandler);
    class function New(next: IFareCalculatorHandler = nil): IFareCalculatorHandler;
  End;

implementation

uses SysUtils;

{ TNormalFareCalculatorHandler }

function TNormalFareCalculatorHandler.calculate(segment: TSegment): Double;
begin
  if ((Not segment.isOvernight()) And (Not segment.isSunday())) then
  begin
		Result := segment.distance * Self.FARE;
    Exit;
  end;

  if (not Assigned(Self.FNext)) then
    raise Exception.Create('Erro');

	Result := Self.FNext.calculate(segment);
end;

constructor TNormalFareCalculatorHandler.Create(next: IFareCalculatorHandler);
begin
  Self.FNext := next;
end;

class function TNormalFareCalculatorHandler.New(next: IFareCalculatorHandler = nil): IFareCalculatorHandler;
begin
  Result := Self.Create(next);
end;

end.
