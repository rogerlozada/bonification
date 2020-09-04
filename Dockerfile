FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic as builder

USER root

RUN apt-get update -yqq > /dev/null && \
    apt-get install -yqq default-jre > /dev/null

ENV PATH="$PATH:/root/.dotnet/tools" 

RUN dotnet tool install --global dotnet-sonarscanner &&\ 
    dotnet tool install --global coverlet.console &&\ 
    dotnet tool install --global dotnet-outdated


WORKDIR /app

COPY . ./

RUN dotnet restore

RUN dotnet build

WORKDIR BonificationErp.Tests

RUN dotnet add package coverlet.msbuild

RUN dotnet test --logger 'trx;LogFileName=report.trx' --logger --results-directory ./TestResults /p:CollectCoverage=true /p:CoverletOutput="TestResults/report.coveragexml" /p:CoverletOutputFormat=cobertura || true

WORKDIR TestResults

RUN cp $( (ls -t ./report*.trx) | cut -d'/' -f 2) report.trx || true

RUN ls

FROM scratch AS export-stage
COPY --from=builder /app/BonificationErp.Tests/TestResults/report.trx .
COPY --from=builder /app/BonificationErp.Tests/TestResults/report.coveragexml .