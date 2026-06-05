program HorseServer;

{$MODE DELPHI}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  SysUtils,
  Generics.Collections,
  Horse;

procedure AllCallBAck(Req: THorseRequest; Res: THorseResponse);
var
  LBody: string;
begin
  LBody := 'OK';
  if Req.Method.Equals('POST') then
    LBody := Req.Body;
  Res.Send(LBody);
end;

procedure EchoCallBack(Req: THorseRequest; Res: THorseResponse);
var
  LHeaders: TStringBuilder;
  LHeader: TPair<string, string>;
begin
  LHeaders := TStringBuilder.Create;
  try
    for LHeader in Req.Headers.ToArray do
      LHeaders.Append(Format('%s: %s%s', [LHeader.Key, LHeader.Value, sLineBreak]));

    Res.Send(LHeaders.ToString);
  finally
    LHeaders.Free;
  end;
end;

procedure CookieCallBack(Req: THorseRequest; Res: THorseResponse);
var
  LCookies: TStringBuilder;
  LCookie: TPair<string, string>;
begin
  LCookies := TStringBuilder.Create;
  try
    for LCookie in Req.Cookie.ToArray do
      LCookies.Append(Format('%s=%s%s', [LCookie.Key, LCookie.Value, sLineBreak]));

    Res.Send(LCookies.ToString);
  finally
    LCookies.Free;
  end;
end;

begin
  THorse.All('/', AllCallBack);
  THorse.All('/echo', EchoCallBack);
  THorse.All('/cookie', CookieCallBack);

  THorse.Listen(8080);
end.
