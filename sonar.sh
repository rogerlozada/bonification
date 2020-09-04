export PATH="$PATH:/root/.dotnet/tools"

#dotnet sonarscanner begin /k:"bonification" /d:sonar.host.url="http://35.247.206.238" /d:sonar.login="21e754865cfcd1d0abaf7bc0f666e4331b1ee247" /d:sonar.cs.opencover.reportsPaths="/app/**/coverage.opencover.xml"
#dotnet build ./BonificationErp.sln
#dotnet sonarscanner end /d:sonar.login="21e754865cfcd1d0abaf7bc0f666e4331b1ee247"


# Baixando o Sonarqube
wget https://s3.amazonaws.com/caelum-online-public/1110-jenkins/05/sonar-scanner-cli-3.3.0.1492-linux.zip

# Descompactando o scanner
unzip sonar-scanner-cli-3.3.0.1492-linux.zip

# Rodando o Scanner
        ./sonar-scanner-3.3.0.1492-linux/bin/sonar-scanner   -X \
          -Dsonar.projectKey=bonification \
          -Dsonar.sources=. \
          -Dsonar.host.url=http://35.247.206.238 \
          -Dsonar.login=21e754865cfcd1d0abaf7bc0f666e4331b1ee247