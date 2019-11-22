FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS base
WORKDIR /app
EXPOSE 8090

FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /src
COPY ["ClientAPI.csproj", "./"]
RUN dotnet restore "./ClientAPI.csproj"
COPY . .
WORKDIR /src
RUN dotnet build "ClientAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ClientAPI.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ClientAPI.dll", "--environment=Production"]
