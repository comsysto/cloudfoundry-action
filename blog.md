Passend zur Veröffentlichung des neuen Workflow Features von GitHub, haben wir uns in einem Lab die GitHub Actions angesehen.

Unser erster Eindruck: Es geht ziemlich leicht von der Hand.

# Ausgangssituation

Ein Kunde hat nach einem Starter Projekt gefragt, das zum einen bei GitHub gehostet werden und zum anderen auch gleich ein automatisches Deployment auf Cloud Foundry ermöglichen soll. Vor dem GitHub Workflow Feature hätten wir für CI/CD auf [Travis](https://travis-ci.org/) gesetzt. 

# Lab Logbuch

Bei [Comsysto Reply](https://comsystoreply.de/) können wir uns 3 Tage pro Quartal außerhalb der Projektarbeit mit neuen technischen Themen im Rahmen eines sogenannten Labs beschäftigen. Diesmal haben wir uns dem Thema [GitHub Actions](https://help.github.com/en/actions) angenommen.

## Tag 1

Unsere naive Erwartung war, dass unter [GitHub Actions](https://github.com/actions) eine Action zu finden ist, die das Deployment eines Artefakts auf Cloud Foundry ermöglicht. Da wir keine finden konnten, haben wir mit Hilfe der [Workflow Dokumentation](https://help.github.com/en/actions/automating-your-workflow-with-github-actions) eine eigene [cloudfoundry-action](https://github.com/comsysto/cloudfoundry-action) entwickelt. Orientiert haben wir uns stark an der [gcloud action](https://github.com/actions/gcloud), da sie prinzipiell genau das ermöglicht, was wir auch auf der [Cloud Foundry CLI](https://docs.cloudfoundry.org/cf-cli/install-go-cli.html) ausführen wollen. Bald ist uns aufgegangen, dass Actions aus beliebigen GitHub Public Repositorys in einem Workflow benutzt werden können. Das ist auch ganz klar eine Stärke der GitHub Workflows. Es ermöglicht jedem sehr einfach, der Community Actions zur Verfügung zu stellen, die bereits ein Problem gelöst haben. Die richtige Lizenz vorausgesetzt sind diese Actions auch OpenSource.

## Tag 2

## Tag 3

# build-once-deploy-everywhere Workflow

Das Bauen eines Artefakts vom tatsächlichen Deployment zu trennen, ist grundsätzlich eine gute Idee. Das ermöglicht eine build-once-deploy-everywhere Strategie.

Wie genau erreichen wir das mit dem GitHub Workflow?
