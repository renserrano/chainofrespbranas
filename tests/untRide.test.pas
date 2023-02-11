unit untRide.test;

interface

uses
  DUnitX.TestFramework, untRide, untFareCalculatorHandler;

type
  [TestFixture]
  TMyTestObject = class
  private
    procedure InicializarDados(var ride: TRide);
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CorridaEmDiaSemanaHorarioNormal;
    [Test]
    procedure CorridaEmDiaSemanaHorarioNoturno;
    [Test]
    procedure CorridaDomingoEmHorarioNormal;
    [Test]
    procedure CorridaDomingoEmHorarioNoturno;
    [Test]
    procedure CorridaHorarioPicoAs07H0M;
    [Test]
    procedure CorridaHorarioPicoAs07H30M;
    [Test]
    procedure CorridaHorarioPicoAs08H00M;
    [Test]
    procedure CorridaHorarioPicoAs08H30M;
    [Test]
    procedure CorridaComDistanciaInvalida;
    [Test]
    procedure CorridaComDataInvalida;
    [Test]
    procedure CorridaComValorMinimo;
    [Test]
    procedure CorridaNoDiaPrimeiro;
  end;

implementation

{ TMyTestObject }

uses untFirstDayFareCalculatorHandler, untNormalFareCalculatorHandler,
  untOvernightFareCalculatorHandler, untOvernightSundayFareCalculatorHandler,
  untPeakTimeFareCalculatorHandler, untSundayFareCalculatorHandler,
  DateUtils, SysUtils;

procedure TMyTestObject.CorridaEmDiaSemanaHorarioNormal;
  var
    ride: TRide;
begin
  InicializarDados(ride);
  ride.addSegment(10, EncodeDateTime(2021, 3, 10, 10, 0, 0, 0));
  Assert.IsTrue(ride.calculateFare = 21, 'Corrida em um dia de semana em horário deve ser 21');
  FreeAndNil(ride);
end;

procedure TMyTestObject.CorridaEmDiaSemanaHorarioNoturno;
  var
    ride: TRide;
begin
  InicializarDados(ride);
  ride.addSegment(10, EncodeDateTime(2021, 3, 10, 23, 0, 0, 0));
  Assert.IsTrue(ride.calculateFare = 39, 'Corrida em um dia de semana e horário noturno falhou');
  FreeAndNil(ride);
end;

procedure TMyTestObject.CorridaComDataInvalida;
  var
    ride: TRide;
begin
  InicializarDados(ride);

  Assert.WillRaise(procedure ()
  begin
    ride.addSegment(10, EncodeDateTime(0, 0, 0, 0, 0, 0, 0));
  end, nil, 'Invalid date');

  FreeAndNil(ride);
end;

procedure TMyTestObject.CorridaComDistanciaInvalida;
  var
    ride: TRide;
begin
  InicializarDados(ride);

  Assert.WillRaise(procedure ()
  begin
    ride.addSegment(-10, EncodeDateTime(2021, 3, 7, 23, 0, 0, 0));
  end, nil, 'Invalid distance');

  FreeAndNil(ride);
end;

procedure TMyTestObject.CorridaComValorMinimo;
  var
    ride: TRide;
begin
  InicializarDados(ride);
  ride.addSegment(1, EncodeDateTime(2021, 3, 10, 10, 0, 0, 0));
  Assert.IsTrue(ride.calculateFare = 10, 'Corrida com valor mínimo deve ser 10');
  FreeAndNil(ride);
end;

procedure TMyTestObject.CorridaDomingoEmHorarioNormal;
  var
    ride: TRide;
begin
  InicializarDados(ride);
  ride.addSegment(10, EncodeDateTime(2021, 3, 7, 10, 0, 0, 0));
  Assert.IsTrue(ride.calculateFare = 29, '');
  FreeAndNil(ride);
end;

procedure TMyTestObject.CorridaDomingoEmHorarioNoturno;
  var
    ride: TRide;
begin
  InicializarDados(ride);
  ride.addSegment(10, EncodeDateTime(2021, 3, 7, 23, 0, 0, 0));
  Assert.IsTrue(ride.calculateFare = 50, '');
  FreeAndNil(ride);
end;

procedure TMyTestObject.CorridaHorarioPicoAs07H0M;
  var
    ride: TRide;
begin
  InicializarDados(ride);
  ride.addSegment(10, EncodeDateTime(2021, 03, 10, 7, 0, 0, 0));
  Assert.IsTrue(ride.calculateFare = 60, '');
  FreeAndNil(ride);
end;

procedure TMyTestObject.CorridaHorarioPicoAs07H30M;
  var
    ride: TRide;
begin
  InicializarDados(ride);
  ride.addSegment(10, EncodeDateTime(2021, 03, 10, 7, 30, 0, 0));
  Assert.IsTrue(ride.calculateFare = 60, '');
  FreeAndNil(ride);
end;

procedure TMyTestObject.CorridaHorarioPicoAs08H00M;
  var
    ride: TRide;
begin
  InicializarDados(ride);
  ride.addSegment(10, EncodeDateTime(2021, 03, 10, 8, 0, 0, 0));
  Assert.IsTrue(ride.calculateFare = 60, '');
  FreeAndNil(ride);
end;

procedure TMyTestObject.CorridaHorarioPicoAs08H30M;
  var
    ride: TRide;
begin
  InicializarDados(ride);
  ride.addSegment(10, EncodeDateTime(2021, 03, 10, 8, 30, 0, 0));
  Assert.IsTrue(ride.calculateFare = 60, '');
  FreeAndNil(ride);
end;

procedure TMyTestObject.CorridaNoDiaPrimeiro;
  var
    ride: TRide;
begin
  InicializarDados(ride);
  ride.addSegment(10, EncodeDateTime(2021, 3, 1, 10, 0, 0, 0));
  Assert.IsTrue(ride.calculateFare = 100, 'Corrida no dia Primeiro deve ser 100');
  FreeAndNil(ride);
end;

procedure TMyTestObject.InicializarDados(var ride: TRide);
  var
    normal : IFareCalculatorHandler;
  	overnightSunday : IFareCalculatorHandler;
	  overnight : IFareCalculatorHandler;
  	sunday : IFareCalculatorHandler;
	  peakTime : IFareCalculatorHandler;
  	firstDay : IFareCalculatorHandler;
begin
	normal := TNormalFareCalculatorHandler.new();
	overnightSunday := TOvernightSundayFareCalculatorHandler.new(normal);
	overnight := TOvernightFareCalculatorHandler.new(overnightSunday);
	sunday := TSundayFareCalculatorHandler.new(overnight);
	peakTime := TPeakTimeFareCalculatorHandler.new(sunday);
	firstDay := TFirstDayFareCalculatorHandler.new(peakTime);
  ride := TRide.Create(firstDay);
end;

procedure TMyTestObject.Setup;
begin

end;

procedure TMyTestObject.TearDown;
begin

end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);

end.
