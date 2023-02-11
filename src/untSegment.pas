unit untSegment;

interface

type
  TSegment = class
  private
    date : TDateTime;
    FDistance : Double;
  public
    function isFirstDay: Boolean;
    function isValidDistance(distance: Double): Boolean;
    function isValidDate(const Date: TDate): Boolean;
    function isSunday: Boolean;
    function isOvernight: Boolean;
    function isPeakTime: Boolean;
    property distance: Double read FDistance write FDistance;
    constructor Create(distance: Double; date: TDateTime);
  End;

implementation

uses DateUtils, SysUtils;

{ TSegment }

constructor TSegment.Create(distance: Double; date: TDateTime);
begin
  Self.distance := distance;
  Self.date := date;

  if (not Self.isValidDistance(distance)) then raise Exception.Create('Invalid distance');
  if (not Self.isValidDate(DateOf(date))) then raise Exception.Create('Invalid date');
end;

function TSegment.isFirstDay: Boolean;
begin
  Result := DayOf(Self.date) = 1;
end;

function TSegment.isOvernight: Boolean;
begin
  Result := (HourOf(Self.date) >= 22) or
            (HourOf(Self.date) <= 6);
end;

function TSegment.isPeakTime: Boolean;
begin
  Result := ((HourOf(Self.date) >= 7) and (HourOf(Self.date) <= 8)) or
            ((HourOf(Self.date) >= 18) and (HourOf(Self.date) <= 19));
end;

function TSegment.isSunday: Boolean;
begin
  Result := DayOfTheWeek(Self.date) = DaySunday;
end;

function TSegment.isValidDate(const Date: TDate): Boolean;
begin
  Result := False;

  If (Date = 0) Then
    Exit;

  If (Date = EncodeDate(1899, 12, 30)) Then
    Exit;

  Result := True;
end;

function TSegment.isValidDistance(distance: Double): Boolean;
begin
  Result := False;

  If (distance <= 0) Then
    Exit;

  Result := True;
end;

end.
