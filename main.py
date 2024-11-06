# F1 Stats
# Analiza o campeonato e mostra as chances de vitória de cada piloto e equipe e os possíveis cenários de campeonato

import requests
from pysondb import db


def import_drivers():

    url = "https://api.openf1.org/v1/drivers"

    payload = {}
    headers = {}

    response = requests.request("GET", url, headers=headers, data=payload)

    # Salva em um banco de dados json
    database = db.getDb("./data.json")

    database.add({"f1": {"drivers": response.json()}})


def import_teams():

    url = "https://api.openf1.org/v1/teams"

    payload = {}
    headers = {}

    response = requests.request("GET", url, headers=headers, data=payload)

    database = db.getDb("./data.json")
    database.add({"f1": {"teams": response.json()}})


def import_seasons():

    url = "https://api.openf1.org/v1/seasons"

    payload = {}
    headers = {}

    response = requests.request("GET", url, headers=headers, data=payload)

    database = db.getDb("./data.json")
    database.add({"f1": {"seasons": response.json()}})


if __name__ == "__main__":
    import_drivers()
    import_teams()
    import_seasons()
