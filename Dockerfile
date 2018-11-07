FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["HelloWebAppLinux.csproj", "./"]
RUN dotnet restore "./HelloWebAppLinux.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "HelloWebAppLinux.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "HelloWebAppLinux.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "HelloWebAppLinux.dll"]
