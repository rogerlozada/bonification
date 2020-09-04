 
FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic

#RUN export PATH="$PATH:/root/.dotnet/tools"
#RUN dotnet tool install --global dotnet-sonarscanner
#RUN dotnet tool install --global coverlet.console

USER root

RUN apt-get update -yqq > /dev/null && \
    apt-get install -yqq default-jre > /dev/null

#RUN useradd -ms /bin/bash jenkins

#USER jenkins

ENV PATH="$PATH:/root/.dotnet/tools" 

RUN dotnet tool install --global dotnet-sonarscanner &&\ 
    dotnet tool install --global coverlet.console &&\ 
    dotnet tool install --global dotnet-outdated

RUN dotnet sonarscanner -h

WORKDIR /app

COPY . ./

RUN dotnet test ./BonificationErp.Tests/BonificationErp.Tests.csproj \
                            --configuration Debug \
                            --output ../output-tests  \
                            /p:CollectCoverage=true \
                            /p:CoverletOutputFormat=opencover \
                            /p:CoverletOutput='/output-coverage/coverage.xml' \
                            /p:Exclude="[BonificationErp.*.Tests]*"

RUN dotnet sonarscanner begin /k:"bonification-teste" \
                            /d:sonar.host.url="http://35.247.206.238" \
                            /d:sonar.login="87b4b1d67aeb0f2d9728ac9d782232d9373425ad" \
                            /d:sonar.cs.opencover.reportsPaths="/output-coverage/coverage.xml" \
                            /d:sonar.coverage.exclusions="tests/*/,Examples/*/,*/.CodeGen.cs" \
                                /d:sonar.test.exclusions="tests/*/,Examples/*/,*/.CodeGen.cs" \
                                     /d:sonar.exclusions="tests/*/,Examples/*/,*/.CodeGen.cs"
                        
RUN dotnet build ./BonificationErp.sln
RUN dotnet sonarscanner end /d:sonar.login="87b4b1d67aeb0f2d9728ac9d782232d9373425ad"


#RUN dotnet sonarscanner begin /k:"bonification" /d:sonar.host.url="http://35.247.206.238" /d:sonar.login="87b4b1d67aeb0f2d9728ac9d782232d9373425ad" 
#RUN dotnet build ./BonificationErp.sln
#RUN dotnet sonarscanner end /d:sonar.login="87b4b1d67aeb0f2d9728ac9d782232d9373425ad"




