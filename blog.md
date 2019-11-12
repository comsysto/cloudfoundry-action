Passend zur Veröffentlichung des neuen Workflow Features von GitHub, haben wir uns in einem Lab die GitHub Actions angesehen.

Unser erster Eindruck. Geht ziemlich leicht von der Hand.

# Ausgangssituation

Ein Kunde hat nach einem Starter Projekt gefragt, das zum Einen bei GitHub gehostet werden und zum Anderen auch gleich ein automatisches deployment auf cloudfoundry ermöglichen soll. Vor dem GitHub Workflow Feature hätten wir für CI/CD auf travis gesetzt. 

# Lab Logbuch

Bei [Comsysto Reply](https://comsystoreply.de/) können wir uns 3 Tage pro Quartal außerhalb der Projektarbeit mit neuen technischen Themen im Rahmen eines sogenannten Labs beschäfftigen.

## Tag 1

Unser naive Erwartung war, dass unter [GitHub Actions](https://github.com/actions) eine Action zu finden ist, die das deployment eines Artefakts auf CloudFoundry ermöglich. Da wir keine finden konnten, haben wir mit Hilfe der [Workflow Dokumentation](https://help.github.com/en/actions/automating-your-workflow-with-github-actions) eine eigene [cloudfoundry-action](https://github.com/comsysto/cloudfoundry-action) entwickelt. Orientiert haben wir uns stark an der [gcloud action](https://github.com/actions/gcloud), da sie prinzipiell genau das ermöglicht, was wir auf der cloudfoundry cli ausführen wollen. Bald ist uns aufgegangen, dass Actions aus beliebigen GitHub Public Repositorys in einem Workflow benutzt werden können. Das ist auch ganz klar eine Stärke der GitHub Workflows. Ermöglicht es doch jedem sehr einfach der community Actions zur Verfügung zu stellen, die bereits ein Problem gelöst haben. Die richtige Lizenz vorausgesetzt sind diese Actions auch OpenSource.

## Tag 2

## Tag 3

# build-once-deploy-everywhere Workflow

Das bauen eines Artefakts vom tatsächlichen deployment zu trennen ist grundsätzlich eine gute Idee. Das ermöglicht eine build-once-deploy-everywhere Strategie.

Wie genau erreichen wir das mit dem GitHub Workflow?
