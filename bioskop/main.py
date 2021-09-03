from operator import attrgetter

import mysql.connector

import CRUD
import Model


# ovde stavljas za PASSWD sifru za logovanje na svoj mysql
my_db = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="palacinke",
    database="mydb"
)

user = ""
movies = None
projections = None
blagajnik_id = None


# def db():
#     my_cursor = my_db.cursor()
#     my_cursor.execute("SELECT * FROM Blagajnik")
#     my_result = my_cursor.fetchall()
#     for x in my_result:
#         print(x)


def login():
    global user
    print(">>> Logovanje na sistem kao blagajnik...")
    x = input("-> Korisnicko ime: ")
    y = input("-> Sifra: ")
    ok = CRUD.fetch_blagajnik(x, y)
    if ok:
        user = x
    return ok


def signup():
    print(">>> Pravljanje naloga za blagajnika...")
    more = True
    while more:
        x = input("-> Korisnicko ime: ")
        y1 = input("-> Sifra: ")
        y2 = input("-> Ponovo unesite sifru: ")
        if y1 == y2:
            more = False
    CRUD.createBlagajnika(x, y1)
    return login()


# metoda koja dobavi filmove iz baze i napravi niz objekata filmova
def dobaviFilmove():
    global movies
    filmovi = CRUD.fetch_sve_filmove()
    movies = []
    for f in filmovi:
        movies.append(Model.Movie(f[0], f[1], f[2], f[3], f[4]))


def prikaziProjekcije():
    global projections
    print("Prikazi sortirano po:")
    print("1 - Vremenu emitovanja")
    print("2 - Ceni karte")
    x = input("[1/2]? ")
    projekcije = CRUD.fetch_projekcije()
    if x == "1":
        projekcije.sort(key=attrgetter('datumProjekcije'))
    elif x == "2":
        projekcije.sort(key=attrgetter('cenaKarte'))
    projections = projekcije
    br = 0
    for p in projekcije:
        br += 1
        print(str(br) + ". " + p.to_str())


def odaberiNekuProjekciju():
    x = input("Unesi redni broj projekcije: ")
    projekcija = projections[int(x)-1]
    # print("Odabrana projekcija: " + projekcija.to_str())
    sala = CRUD.fetch_whole_sala_by_id(projekcija.id_sala)
    karte_data = CRUD.fetch_karte(projekcija.id_sala, projekcija.id_film)
    karte = []
    for k in karte_data:
        karte.append((k[1], k[2]))
    for k in karte:
        print(k)
    ii = sala[0][2]
    jj = sala[0][3]

    print(" ", end="  ")
    for x in range(jj):
        print(x+1, end=" ")
    print()
    for i in range(ii):
        print(i+1, end="  ")
        for j in range(jj):
            if karte.__contains__((i, j)):
                print("@", end=" ")
            else:
                print("-", end=" ")
        print()

    xi = int(input("Unesi red: "))
    xi -= 1
    xj = int(input("Unesi sediste: "))
    xj -= 1
    global blagajnik_id
    if not karte.__contains__((i, j)):
        if xi < ii and xj < jj:
            CRUD.new_karta(xi, xj, projekcija.id_film, projekcija.id_sala, blagajnik_id)
            CRUD.povecaj_posecenost_filmu(projekcija.id_film)



def prikaziRepertoar():
    dobaviFilmove()
    global movies
    for m in movies:
        print(m.to_str())
    x = input("Prikazi projekcije? [Y/n] ")
    if x == "n":
        return
    prikaziProjekcije()
    odaberiNekuProjekciju()


def prikaziNajgledanijiFilm():
    dobaviFilmove()
    global movies
    best = movies[0]
    for m in movies:
        if best.views < m.views:
            best = m
    print("Najgledaniji film je:" + best.name + " (" + str(best.views) +" pregleda)")


def prikaziFilmSaNajboljomOcenom():
    dobaviFilmove()
    global movies
    best = movies[0]
    for m in movies:
        if best.mark < m.mark:
            best = m
    print(best.to_str())


def pretraziFilmovePoZeljenomGlumcu():
    x = input("Unesite ime i prezime glumca za pretragu: ")
    x = x.split(" ")
    if len(x) != 2:
        print("Nevalidan unos!")
        return
    filmovi = CRUD.fetch_by_glumac(x[0], x[1])
    if filmovi:
        print("Rezultati pretrage:")
        for f in filmovi:
            print(" - " + f[0])
    else:
        print("Nema rezultata...")


def koJeNajboljiBlagajnik():
    CRUD.find_the_best_blagajnik()


# 3
def menu():
    more = True
    while more:
        print(">>> Odaberite akciju:")
        print("1 - Prikazi repertoar")
        print("2 - Prikazi najgledaniji film")
        print("3 - Prikazi film sa najboljom ocenom")
        print("4 - Pretrazi filmove po zeljenom glumcu")
        print("5 - Pogledaj ko je blagajnik sa najvise prodatih karata")
        more = False
        x = input("-> ")
        if x == "1":
            prikaziRepertoar()
        elif x == "2":
            prikaziNajgledanijiFilm()
        elif x == "3":
            prikaziFilmSaNajboljomOcenom()
        elif x == "4":
            pretraziFilmovePoZeljenomGlumcu()
        elif x == "5":
            koJeNajboljiBlagajnik()
        else:
            print("Nevalidan unos...Probaj ponovo")
        x = input("Novi izbor akcije? [Y/n] ")
        if x != "n" and x != "N":
            more = True


# 2
def main():
    global user
    global blagajnik_id
    print("*** BIOSKOP ***")
    print(">>> Odaberite jednu od punudjenih opcija:")
    print("1 - Logovanje")
    print("2 - Napravite nalog ukoliko nemate")
    if input("-> ") == "1":
        next = login()
        # next = "a"
    else:
        next = signup()
    if not next:
        print("x x x - N E U S P E S N O - x x x")
        return
    blagajnik_id = next

    print()
    print("*** Dobrodosli,", user, "***")
    print()
    menu()    


# 1
if __name__ == '__main__':
    main()