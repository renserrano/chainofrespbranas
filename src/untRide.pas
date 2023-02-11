unit untRide;

interface

uses Classes, SysUtils, untSegment, System.Generics.Collections, untFareCalculatorHandler;

type
  TRide = class
  private
    const MIN_FARE = 10;
  private
    fareCalculatorHandler: IFareCalculatorHandler;
    segments : TList<TSegment>;
  public
    procedure addSegment(distance: Double; date: TDateTime);
    function calculateFare(): Double;
    constructor Create(fareCalculatorHandler: IFareCalculatorHandler);
    destructor Destroy; override;
  End;

implementation

uses Math;

{ TRide }

procedure TRide.addSegment(distance: Double; date: TDateTime);
  var
    segment : TSegment;
begin
  segment := TSegment.Create(distance, date);
  Self.segments.Add(segment);
end;

function TRide.calculateFare: Double;
  var
    fare : Double;
    segment : TSegment;
begin
  fare := 0;

	for segment in Self.segments do
  begin
		fare := fare + Self.fareCalculatorHandler.calculate(segment);
  end;

	Result := IfThen(fare < Self.MIN_FARE, Self.MIN_FARE, fare);
end;

constructor TRide.Create(fareCalculatorHandler: IFareCalculatorHandler);
begin
  Self.fareCalculatorHandler := fareCalculatorHandler;
  segments := TList<TSegment>.Create;
end;

destructor TRide.Destroy;
begin
  FreeAndNil(segments);
  inherited;
end;

end.
