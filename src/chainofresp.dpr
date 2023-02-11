program chainofresp;

uses
  Vcl.Forms,
  untMain in 'untMain.pas' {Form1},
  untNormalFareCalculatorHandler in 'untNormalFareCalculatorHandler.pas',
  untFareCalculatorHandler in 'untFareCalculatorHandler.pas',
  untSegment in 'untSegment.pas',
  untFirstDayFareCalculatorHandler in 'untFirstDayFareCalculatorHandler.pas',
  untOvernightFareCalculatorHandler in 'untOvernightFareCalculatorHandler.pas',
  untOvernightSundayFareCalculatorHandler in 'untOvernightSundayFareCalculatorHandler.pas',
  untPeakTimeFareCalculatorHandler in 'untPeakTimeFareCalculatorHandler.pas',
  untSundayFareCalculatorHandler in 'untSundayFareCalculatorHandler.pas',
  untRide in 'untRide.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
