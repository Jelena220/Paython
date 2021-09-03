import CRUD


class Movie:
    def __init__(self, id, name, director, mark, views):
        self.id = id
        self.name = name
        self.director = director
        self.mark = mark
        self.views = views

    def to_str(self):
        return self.name + " - " + str(self.mark) + " \t(Reziser: " + self.director + ")"


class Projekcija:
    def __init__(self, id_film, id_sala, datumProjekcije, cenaKarte):
        self.id_film = id_film
        self.id_sala = id_sala
        self.datumProjekcije = datumProjekcije
        self.cenaKarte = cenaKarte

        self.naziv_filma = CRUD.fetch_film_by_id(id_film)
        self.broj_sale = CRUD.fetch_sala_by_id(id_sala)

    def to_str(self):
        return "Projekcija filma "+self.naziv_filma + " - " + self.broj_sale + " \t(" + self.datumProjekcije.strftime("%d.%m.%Y - %H:%M") + ")   ->   [" + str(self.cenaKarte) + "din]"
