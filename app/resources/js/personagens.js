const modalCharacterNameTag = document.querySelector(".modal-body #nome-personagem")
const modalCharacterValue = document.querySelector(".modal-footer input")
const modal = document.querySelector(".modal")

modal.addEventListener("hide.bs.modal", () => {
    setTimeout(() => {
        modalCharacterNameTag.textContent = ""
        modalCharacterValue.value = ""
    }, 150)
})

$.getJSON("/api/personagens_usuario/", (json) => {
    // pega todas as tendencias da api
    for (let i = 0; i < json.length; i++) {
        document.querySelector(".criar-personagem").insertAdjacentHTML(
            "afterend",
            `<div>
            <div class="card-personagem">
                <div class="card-color" style="background-color: ${json[i].cor_ficha}">
                    <img src="${json[i].url_imagem}" alt="" />
                </div>
                <div class="desc">
                    <div class="buttons">
                        <a href="#" class="edit-button">
                            <img src="/images/svg/pencil.svg" alt="">
                        </a>
                        <h3>${json[i].nome_personagem}</h3>
                        <a href="#" class="delete-button" data-bs-toggle="modal" data-bs-target="#excluirPersonagem">
                            <img src="/images/svg/trash-white.svg" alt="">
                        </a>
                    </div>
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
        </div>
        `
        )

        const thisCard = document.querySelector(".meus-personagens").children[1]

        thisCard.addEventListener("click", (e) => {
            const editButton = thisCard.querySelector(".edit-button")
            const deleteButton = thisCard.querySelector(".delete-button")

            // caso o usuário clicar no botão de editar, ele será redirecionado para a página de edição
            if (e.target === editButton || e.target === editButton.children[0]) {
                window.location = "/ficha/" + json[i].id_personagem + "/editar"
                return
            }

            // caso o usuário clicar no botão de excluir, um pop-up aparecerá
            if (e.target === deleteButton || e.target === deleteButton.children[0]) {
                modalCharacterValue.value = json[i].id_personagem
                modalCharacterNameTag.textContent = json[i].nome_personagem

                return
            }

            window.location = "/ficha/" + json[i].id_personagem
        })
    }
})
