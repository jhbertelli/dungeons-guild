const modalWorldNameTag = document.querySelector(".modal-body #nome-mundo")
const modalWorldValue = document.querySelector(".modal-footer input")
const codigoForm = document.getElementById("procurarCodigo")
const submitButton = codigoForm.querySelector(".modal-footer button")
const codigoInput = codigoForm.querySelector("input")
const smallText = codigoForm.querySelector("small")
const modal = document.querySelector(".modal")
const mundosDiv = document.querySelector(".mundos-comunidade")

console.log(window.location.search)

$.get("/api/pesquisar_mundo/", window.location.search, (data, status) => {
    // pega os mundos da API
    for (let i = 0; i < data.length; i++) {
        // loop que cicla por cada mundo que a API retornou
        const world = data[i]
        mundosDiv.innerHTML += `<div class="card-mundo" onclick="window.location = '/mundo/' + ${world.id_mundo}">
                    <img src="${world.imagem_mundo}" alt="" />
                    <div class="desc">
                        
                            <h3 style="margin-top: 8px;">${world.nome_mundo}</h3>
                        
                        <hr />
                        <table>
                            <tr>
                                <th>
                                    <img src="/images/svg/mestre.svg" alt="" />
                                    <span>Mestre:</span>
                                </th>
                                <td>${world.mestre}</td>
                            </tr>
                            <tr>
                                <th>
                                    <img src="/images/svg/personagens.svg" alt="" />
                                    <span>Integrantes:</span>
                                </th>
                                <td>${world.quant_participantes}</td>
                            </tr>
                            <tr>
                                <th>
                                    <img src="/images/svg/personagens.svg" alt="" />
                                    <span>I. necessários:</span>
                                </th>
                                <td>${world.jgdorNeces_mundo}</td>
                            </tr>
                            <tr>
                                <th>
                                    <img src="/images/svg/tema.svg/" alt="" />
                                    <span>Tema:</span>
                                </th>
                                <td>${world.tema_mundo}</td>
                            </tr>
                        </table>
                    </div>
                </div>`
    }
})

modal.addEventListener("hide.bs.modal", () => {
    setTimeout(() => {
        modalWorldNameTag.textContent = ""
        modalWorldValue.value = ""
    }, 150)
})

function errorMessage(message) {
    codigoInput.style.boxShadow = "0px 0px 8px red"
    codigoInput.style.outline = "solid 1px red"
    smallText.textContent = message
}

codigoInput.addEventListener("input", () => {
    if (codigoInput.value === "") return errorMessage("Preencha este campo")

    smallText.textContent = ""
    codigoInput.style.boxShadow = "none"
    codigoInput.style.outline = "none"
})

submitButton.addEventListener("click", (e) => {
    e.preventDefault()

    if (codigoInput.value === "") {
        errorMessage("Preencha este campo")
        return
    }
    
    // envia o código digitado pelo usuário para o back-end, que verifica se há algum mundo privado com esse código
    $.get("/api/verify_world_code/" + codigoInput.value, (data, status) => {
        if (data.sucess) return codigoForm.submit()

        errorMessage("Você inseriu um código inválido")
    })
})
