unit untFareCalculatorHandler;

interface

uses untSegment;

type
  IFareCalculatorHandler = Interface
	  function calculate(segment: TSegment): Double;
  end;

implementation

end.
