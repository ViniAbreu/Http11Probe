FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY Directory.Build.props .
COPY src/Servers/EffinitiveServer/ src/Servers/EffinitiveServer/
RUN dotnet restore src/Servers/EffinitiveServer/EffinitiveServer.csproj
RUN dotnet publish src/Servers/EffinitiveServer/EffinitiveServer.csproj -c Release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/runtime:10.0
WORKDIR /app
COPY --from=build /app .
USER $APP_UID
ENTRYPOINT ["dotnet", "EffinitiveServer.dll", "8080"]
