program HorseServer;

{$MODE DELPHI}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  SysUtils,
  Generics.Collections,
  Horse;

procedure GetCallBack(Req: THorseRequest; Res: THorseResponse);
begin
  Res.Send('OK');
end;

procedure PostCallBAck(Req: THorseRequest; Res: THorseResponse);
begin
  Res.Send(Req.Body);
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
  THorse.Get('/', GetCallBack);
  THorse.Post('/', PostCallBack);
  THorse.All('/echo', EchoCallBack);
  THorse.All('/cookie', CookieCallBack);

  THorse.Listen(8080);
end.
