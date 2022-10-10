$.getJSON("/api/personagens_usuario/", (json) => {
    // pega todas as tendencias da api
    for (let i = 0; i < json.length; i++) {
        document.querySelector(
            ".meus-personagens"
        ).innerHTML += `
        <div class="card-personagem">
            <div class="card-color" style="background-color: ${json[i].cor_ficha}">
                <img src="${json[i].url_imagem}" alt="" />
            </div>
            <div class="desc">
                <h3>${json[i].nome_personagem}</h3>
                <hr />
                <table>
                    <tr>
                        <th>
                            <img
                                src="http://127.0.0.1:5000/images/svg/shield-sword.svg"
                                alt=""
                            />
                            <span>Classe:</span>
                        </th>
                        <td>${json[i].nome_classe}</td>
                    </tr>
                    <tr>
                        <th>
                            <img
                                src="http://127.0.0.1:5000/images/svg/badge.svg"
                                alt=""
                            />
                            <span>Nível:</span>
                        </th>
                        <td>${json[i].nivel_personagem}</td>
                    </tr>
                    <tr>
                        <th>
                            <img
                                src="http://127.0.0.1:5000/images/svg/person.svg"
                                alt=""
                            />
                            <span>Raça:</span>
                        </th>
                        <td>${json[i].nome_raca}</td>
                    </tr>
                    <tr>
                        <th>
                            <img
                                src="http://127.0.0.1:5000/images/svg/scroll.svg"
                                alt=""
                            />
                            <span>Antecedente:</span>
                        </th>
                        <td>${json[i].antecedente}</td>
                    </tr>
                </table>
            </div>
        </div>
        `
    }
})