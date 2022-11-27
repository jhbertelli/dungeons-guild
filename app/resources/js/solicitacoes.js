// pega o id do mundo pela url - 2 é a posição do id na url
const idMundo = window.location.pathname.split("/")[2]
const listaSolicitacoes = document.querySelector(".solicitacoes")

function handleSolicitation(type, userId, solicitationDiv) {
    // cria uma requisição para o servidor
    // se a solicitação foi aceita/rejeitada, o id do usuário que enviou a solicitação
    // e o id do mundo
    const request = {
        type,
        userId,
        idMundo
    }

    // envia a solicitação
    $.post(`/api/mundo/${idMundo}/solicitacoes`, request, (response) => {
        // remove o elemento caso a solitação seja aceita/rejeitada com sucesso
        if (response.sucess) {
            solicitationDiv.remove()
        }

        // caso o mundo não tenha mais solicitações
        if (listaSolicitacoes.childElementCount === 0) {
            listaSolicitacoes.style.justifyContent = "center"
            listaSolicitacoes.style.paddingTop = "0"
            listaSolicitacoes.textContent =
                "Não há nenhuma solicitação de viajantes para entrar no seu mundo"

            return
        }

        listaSolicitacoes.children[0].style.borderTop = "white 1px solid"
    })
}

$.getJSON(`/api/mundo/${idMundo}/solicitacoes/`, (json) => {
    if (json.length > 0) {
        for (let i = 0; i < json.length; i++) {
            listaSolicitacoes.innerHTML += `<div class="solicitacao-usuario" style="${
                i === 0 ? "" : "border-top: none"
            }">
                <div class="usuario">
                    <img src="/images/svg/mail.svg/" alt="">
                    <p>Solicitação de: <span>${json[i].apelido_cadastro} (${
                json[i].nome_cadastro
            })</span></p>
                </div>
                <div class="gerenciar-solicitacao">
                    <button onclick="handleSolicitation('accept', ${
                        json[i].id_usuario
                    }, this.closest('.solicitacao-usuario'))">
                    <img src="/images/svg/check.svg/" alt="">
                    </button>
                    <button onclick="handleSolicitation('reject', ${
                        json[i].id_usuario
                    }, this.closest('.solicitacao-usuario'))">
                        <img src="/images/svg/accept.svg/" alt="">
                    </button>
                </div>
            </div>`
        }

        return
    }

    listaSolicitacoes.style.justifyContent = "center"
    listaSolicitacoes.style.paddingTop = "0"
    listaSolicitacoes.textContent =
        "Não há nenhuma solicitação de viajantes para entrar no seu mundo"
})
