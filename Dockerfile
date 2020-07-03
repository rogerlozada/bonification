FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic as builder

WORKDIR /app

COPY . ./

RUN dotnet restore

RUN dotnet build

WORKDIR BonificationErp.Tests

RUN dotnet test --logger "trx;LogFileName=report.trx"

RUN ls

FROM scratch AS export-stage
COPY --from=builder /app/BonificationErp.Tests/TestResults/report.trx .
