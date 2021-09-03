import mysql.connector

import Model

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="palacinke",
    database="mydb"
)

def createBlagajnika(username, password):
    my_cursor = mydb.cursor()
    sql = "INSERT INTO Blagajnik (korisnickoIme, sifra) VALUES (%s, %s)"
    val = (username, password)
    my_cursor.execute(sql, val)
    mydb.commit()


def fetch_blagajnik(username, password):
    my_cursor = mydb.cursor()
    sql = "SELECT * FROM Blagajnik b WHERE b.korisnickoIme COLLATE utf8_bin LIKE %s AND b.sifra LIKE %s"
    val = (username, password)
    my_cursor.execute(sql, val)
    my_result = my_cursor.fetchall()
    if my_result:
        return my_result[0][0]
    else:
        return False


def fetch_sve_filmove():
    my_cursor = mydb.cursor()
    sql = "SELECT * FROM Film"
    my_cursor.execute(sql)
    my_result = my_cursor.fetchall()
    return my_result


def fetch_film_by_id(id):
    my_cursor = mydb.cursor()
    sql = "SELECT f.nazivFilma FROM Film f WHERE f.idFilm = %s"
    val = (id,)
    my_cursor.execute(sql, val)
    my_result = my_cursor.fetchall()
    return my_result[0][0]


def fetch_whole_sala_by_id(id):
    my_cursor = mydb.cursor()
    sql = "SELECT * FROM Sala s WHERE s.idSala = %s"
    val = (id,)
    my_cursor.execute(sql, val)
    my_result = my_cursor.fetchall()
    return my_result


def fetch_karte(id_sala, id_film):
    my_cursor = mydb.cursor()
    sql = "SELECT * FROM Karta k WHERE k.Projekcija_Film_idFilm = %s AND k.Projekcija_Sala_idSala = %s"
    val = (id_film, id_sala)
    my_cursor.execute(sql, val)
    my_result = my_cursor.fetchall()
    return my_result


def fetch_sala_by_id(id):
    my_cursor = mydb.cursor()
    sql = "SELECT s.brojSale FROM Sala s WHERE s.idSala = %s"
    val = (id,)
    my_cursor.execute(sql, val)
    my_result = my_cursor.fetchall()
    return my_result[0][0]


def fetch_by_glumac(ime, prezime):
    my_cursor = mydb.cursor()
    sql = "SELECT f.nazivFilma FROM Film f WHERE f.idFilm = (SELECT u.Film_idFilm FROM Uloga u WHERE u.Glumac_idGlumac in (SELECT g.idGlumac FROM Glumac g WHERE g.imeGlumca = %s AND g.prezimeGlumca = %s))"
    val = (ime, prezime)
    my_cursor.execute(sql, val)
    my_result = my_cursor.fetchall()
    return my_result


def fetch_projekcije():
    my_cursor = mydb.cursor()
    sql = "SELECT * FROM Projekcija;"
    # sql = "SELECT f.nazivFilma FROM Film f WHERE f.idFilm = (SELECT u.Film_idFilm FROM Uloga u WHERE u.Glumac_idGlumac in (SELECT g.idGlumac FROM Glumac g WHERE g.imeGlumca = %s AND g.prezimeGlumca = %s))"
    # val = (ime, prezime)
    my_cursor.execute(sql)
    my_result = my_cursor.fetchall()
    projekcije = []
    for p in my_result:
        projekcije.append(Model.Projekcija(p[0], p[1], p[2], p[3]))
    return projekcije


def new_karta(xi, xj, id_film, id_sala, blagajnik_id):
    my_cursor = mydb.cursor()
    sql = "INSERT INTO Karta(pozicijaI, pozicijaJ, Projekcija_Film_idFilm, Projekcija_Sala_idSala, Blagajnik_idBlagajnik) VALUES(%s, %s, %s, %s, %s)"
    val = (str(xi), str(xj), id_film, id_sala, blagajnik_id)
    my_cursor.execute(sql, val)
    mydb.commit()


def povecaj_posecenost_filmu(id_film):
    my_cursor = mydb.cursor()
    sql = "SELECT f.posecenost FROM Film f WHERE f.idFilm = %s"
    val = (id_film,)
    my_cursor.execute(sql, val)
    my_result = my_cursor.fetchall()
    posecenost = int(my_result[0][0]) + 1
    print(posecenost)

    sql = "UPDATE Film f SET f.posecenost = %s WHERE f.idFilm = %s"
    val = (str(posecenost), str(id_film))
    my_cursor.execute(sql, val)
    mydb.commit()


def find_the_best_blagajnik():
    my_cursor = mydb.cursor()
    sql = "SELECT k.Blagajnik_idBlagajnik, COUNT(*) FROM Karta k GROUP BY k.Blagajnik_idBlagajnik"
    my_cursor.execute(sql)
    my_result = my_cursor.fetchall()
    max_id = my_result[0][0]
    max_br = my_result[0][1]
    for par in my_result:
        if par[1] > max_br:
            max_br = par[1]
            max_id = par[0]
    sql = "Select b.korisnickoIme from Blagajnik b Where b.idBlagajnik = %s"
    val = (max_id,)
    my_cursor.execute(sql, val)
    blagajnik = my_cursor.fetchall()
    print("Blagajnik sa najvise prodatih karata je: " + blagajnik[0][0])
