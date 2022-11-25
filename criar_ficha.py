def post_criar_ficha(session, request, cursor, db, os, create_file_name, secure_filename, get_lists_from_ficha):
    ficha = request.form

    for key in ficha:
        # verifica se há algum campo vazio
        if ficha[key] == '':
            return False

    # verifica se a imagem foi enviada
    if 'img-personagem' not in request.files:
        return False

    image = request.files['img-personagem']

    if image.filename == '':
        return False

    # cria um nome diferente para o arquivo e salva
    image.filename = create_file_name(
    ) + os.path.splitext(image.filename)[1]

    # se por algum acaso o nome já existir na pasta
    while image.filename in os.listdir('app/resources/images/fichas'):
        image.filename = create_file_name(
        ) + os.path.splitext(image.filename)[1]

    filename = secure_filename(image.filename)
    image.save(os.path.join('app/resources/images/fichas', filename))
    url_imagem = '/images/fichas/' + filename

    all_lists = get_lists_from_ficha(ficha)

    lista_ficha = {}

    lista_ficha["nome_personagem"] = ficha.get("nome-personagem")
    lista_ficha["url_imagem"] = url_imagem
    lista_ficha["vida_atual"] = int(ficha.get("vida-atual"))
    lista_ficha["vida_total"] = int(ficha.get("vida-total"))
    lista_ficha["classe"] = int(ficha.get("classe"))
    lista_ficha["nivel"] = int(ficha.get("nivel"))
    lista_ficha["antecedente"] = int(ficha.get("antecedente"))
    lista_ficha["id_jogador"] = session["usuario"]
    lista_ficha["raca"] = int(ficha.get("raca"))
    lista_ficha["tendencia"] = int(ficha.get("tendencia"))
    lista_ficha["xp_atual"] = int(ficha.get("xp-atual"))
    lista_ficha["xp_total"] = int(ficha.get("xp-total"))
    lista_ficha["lista_aparencia"] = all_lists["lista_aparencia"]
    lista_ficha["lista_bonus"] = all_lists["lista_bonus"]
    lista_ficha["cor_ficha"] = ficha.get("cor-ficha")
    lista_ficha["salvaguardas"] = all_lists["lista_salvaguardas"]
    lista_ficha["pericias"] = ficha.getlist("pericias")
    lista_ficha["testes_resistencia"] = ficha.getlist("testes-resistencia")
    lista_ficha["idiomas_proficiencias"] = ficha.get(
        "idiomas-proficiencias").strip()
    lista_ficha["equipamentos"] = ficha.get("equipamentos").strip()
    lista_ficha["lista_dinheiro"] = all_lists["lista_dinheiro"]
    lista_ficha["caracteristicas"] = ficha.get("caracteristicas").strip()
    lista_ficha["magias"] = ficha.getlist("magias")
    lista_ficha["historia"] = ficha.get("historia").strip()
    lista_ficha["tesouro"] = ficha.get("tesouro").strip()
    lista_ficha["aliados"] = ficha.get("aliados").strip()

    sql = f'''INSERT INTO `personagem`
    (`nome_personagem`, `url_imagem` ,`vida_atual`, `vida_total`, `id_classe`, `nivel_personagem`, `id_antecedente`,
    `id_usuario`, `id_raca`, `id_tendencia`, `xp_atual`, `xp_total`, `lista_aparencia`, `lista_bonus`,
    `cor_ficha`, `salvaguardas`, `pericias`, `testes_resistencia`, `idiomas_proficiencias`, `equipamentos`,
    `lista_dinheiro`, `caracteristicas`, `magias`, `historia`, `tesouro`, `aliados`)
    VALUES (
    "{lista_ficha["nome_personagem"]}",
    "{lista_ficha["url_imagem"]}",
    "{lista_ficha["vida_atual"]}",
    "{lista_ficha["vida_total"]}",
    "{lista_ficha["classe"]}",
    "{lista_ficha["nivel"]}",
    "{lista_ficha["antecedente"]}",
    "{lista_ficha["id_jogador"]}",
    "{lista_ficha["raca"]}",
    "{lista_ficha["tendencia"]}",
    "{lista_ficha["xp_atual"]}",
    "{lista_ficha["xp_total"]}",
    "{lista_ficha["lista_aparencia"]}",
    "{lista_ficha["lista_bonus"]}",
    "{lista_ficha["cor_ficha"]}",
    "{lista_ficha["salvaguardas"]}",
    "{lista_ficha["pericias"]}",
    "{lista_ficha["testes_resistencia"]}",
    "{lista_ficha["idiomas_proficiencias"]}",
    "{lista_ficha["equipamentos"]}",
    "{lista_ficha["lista_dinheiro"]}",
    "{lista_ficha["caracteristicas"]}",
    "{lista_ficha["magias"]}",
    "{lista_ficha["historia"]}",
    "{lista_ficha["tesouro"]}",
    "{lista_ficha["aliados"]}")'''

    cursor.execute(sql)
    db.connection.commit()

    return True