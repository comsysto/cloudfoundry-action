# GitHub Workflow - Build once, deploy to every Cloud Foundry
Passend zur Veröffentlichung des neuen Workflow Features von GitHub, haben wir uns in einem Lab die GitHub Actions angesehen.

Unser erster Eindruck: Es geht ziemlich leicht von der Hand.

# Ausgangssituation

Ein Kunde hat nach einem Starter Projekt gefragt, das zum einen bei GitHub gehostet werden und zum anderen auch gleich ein automatisches Deployment auf Cloud Foundry ermöglichen soll.
Vor dem GitHub Workflow Feature haben wir für CI/CD auf [Travis](https://travis-ci.org/) gesetzt und entschieden, dass wir das Projekt in einem Lab auf den GitHub Workflow respektive die GitHub Actions umstellen wollen.

# Lab Logbuch

Bei [Comsysto Reply](https://comsystoreply.de/) können wir uns 3 Tage pro Quartal neben der Projektarbeit mit neuen technischen Themen im Rahmen sogenannter Labs beschäftigen. Im Bezug auf oben genanntes Projekt haben wir diesmal das Thema [GitHub Actions](https://help.github.com/en/actions) näher beleuchtet.

## Tag 1

Unsere naive Erwartung war, dass unter [GitHub Actions](https://github.com/actions) eine Action zu finden ist, die das Deployment eines Artefakts auf Cloud Foundry ermöglicht. 
Da wir keine finden konnten, haben wir mit Hilfe der [Workflow Dokumentation](https://help.github.com/en/actions/automating-your-workflow-with-github-actions) eine eigene [cloudfoundry-action](https://github.com/comsysto/cloudfoundry-action) entwickelt. 
Orientiert haben wir uns stark an der [gcloud action](https://github.com/actions/gcloud), da sie prinzipiell genau das ermöglicht, was wir auch auf der [Cloud Foundry CLI](https://docs.cloudfoundry.org/cf-cli/install-go-cli.html) ausführen wollen. 

Bald ist uns aufgegangen, dass Actions aus beliebigen GitHub Public Repositorys in einem Workflow benutzt werden können. Das ist auch ganz klar eine Stärke von GitHub Actions. Es ermöglicht jedem sehr einfach, der Community Actions zur Verfügung zu stellen, die bereits ein Problem gelöst haben. 
Die richtige Lizenz vorausgesetzt sind diese Actions auch OpenSource.

Das Ergebnis war eine erste Version der [cloudfoundry-action](https://github.com/comsysto/cloudfoundry-action), mit der ein Deployment auf Cloud Foundry möglich war. 
Allerdings war diese Version nicht flexibel einsetzbar, da Annahmen bzgl. der manifest.yml und der auszuliefernden jar Datei in der Action getroffen wurden. 

Am Ende des Tages sah unser Workflow wie folgt aus. Das Bauen einer Software vom tatsächlichen Deployment dieser zu trennen, ist grundsätzlich eine gute Idee. Dazu aber mehr am Ende des Blogs.
Dem Ansatz folgend enthält unser Workflow einen `build:` job und einen `deploy:` job.

```
name: Couldfoundry CI Lab
on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Set up JDK 11
      uses: actions/setup-java@v1
      with:
        java-version: 11
    - name: Build with Gradle
      run: ./gradlew clean build
    - name: Add manifest to build result
      run: cp ./manifest.yaml ./build/libs
    - uses: actions/upload-artifact@v1
      with:
        name: github-action-lab-artifact
        path: build/libs
  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Downlaod artifact
        uses: actions/download-artifact@v1
        with:
          name: github-action-lab-artifact
      - name: Cloudfoundry deployment
        id: cf
        uses: comsysto/cloudfoundry-action@master
        with:
          api: 'https://api.run.pivotal.io'
          org: 'mvg'
          space: 'development'
          user: ${{ secrets.CF_USERNAME }}
          password: ${{ secrets.CF_PASSWORD }}
          artifactDir: github-action-lab-artifact
      - name: Cloudfoundry deployment result
        run: echo "Deployment was ${{ steps.cf.outputs.deploymentResult }}"
```

Der offensichliche Nachteil. Aus dem Workflow geht nicht hervor, welche jar Datei in welcher Weise auf Cloud Foundry ausgeliefert wird. 
Man kann nur annehmen, dass es die ist, die im Step `jobs.deploy.steps.name: Download artifact` step heruntergeladen wurde. 
Vermutlich wird auch irgendwie die im `jobs.build.steps.name: Add manifest to build result` kopierte manifest.yaml verwendet.

## Tag 2

Wir wollten bei der Verwendung der Action alle möglichen Cloud Foundry CLI Kommandos unterstützen, sie damit flexibler und den gesamten Workflow lesbarer machen.
Angelehnt an die [gcloud action](https://github.com/actions/gcloud) haben wir die Action entsprechend angepasst und damit im Grunde einen Cloud Foundry CLI Wrapper geschaffen.
Die Annahmen, die in ersten Version der Action verborgen waren und diese damit auch limitiert haben, konnten somit direkt im Workflow konfiguriert werden.

Die einzige Möglichkeit, Daten zwischen Workflow Jobs zu teilen, ist der [Austausch über sogenannte Artefakte](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/persisting-workflow-data-using-artifacts).
Diesen Mechanismus haben wir schon am Ende von Tag 1 verwendet, um die jar Datei und die manifest.yaml im Deployment Job zur Verfügung zu stellen.

Jetzt da sich die cloudfoundry-action zu einem reinen CLI Wrapper entwickelt hat, brauchten wir wiederum eine Möglichkeit den Pfad zur jar Datei und zur manifest.yaml im `jobs.deploy` Job verfügbar zu machen.
Das erreichen wir durch das Erstellen einer json Datei mit folgendem Inhalt:

```json
{
  "artifactPath": "deploymentArchive/github-action-lab-0.0.1-SNAPSHOT.jar",
  "manifestPath": "deploymentArchive/manifest.yaml"
}
```



## Tag 3

# Fazit und Ausblick

TODO: Statement zu was wir von GitHub Actions halten.
 
Wie schon erwähnt setzen wir auf das Trennen des build jobs vom deploy job. Das ermöglicht eine build-once-deploy-everywhere CD Strategie.

Wie genau? Dem widmen wir uns in unserem nächsten Lab.
