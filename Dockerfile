FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic as builder

WORKDIR /app

COPY . ./

RUN dotnet restore

RUN dotnet build

WORKDIR BonificationErp.Tests

#RUN dotnet test --logger "trx;LogFileName=report.trx" || true
RUN dotnet add package coverlet.msbuild --version 2.9.0

RUN dotnet test --logger 'trx;LogFileName=report.trx' --logger --results-directory ./TestResults /p:CollectCoverage=true /p:CoverletOutput=TestResults/ /p:CoverletOutputFormat=cobertura || true

WORKDIR TestResults

RUN cp $( (ls -t ./report*.trx) | cut -d'/' -f 2) report.trx || true

RUN ls

FROM scratch AS export-stage
COPY --from=builder /app/BonificationErp.Tests/TestResults/report.trx .
