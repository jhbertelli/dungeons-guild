const idMundo = window.location.pathname.split('/')[2]
const listaSolicitacoes = document.querySelector('.solicitacoes')

$.getJSON("/api/mundo/" + idMundo + "/solicitacoes/", (json) => {
    if (json.length > 0) {
        for (let i = 0; i < json.length; i++) {
            listaSolicitacoes.innerHTML += `<div class="solicitacao-usuario">
                <div class="usuario">
                    <img src="/images/svg/mail.svg/" alt="">
                    <p>Solicitação de: <span>${json[i].apelido_cadastro} (${json[i].nome_cadastro})</span></p>
                </div>
                <div class="gerenciar-solicitacao">
                    <button>
                        <img src="/images/svg/accept.svg/" alt="">
                    </button>
                    <button>
                        <img src="/images/svg/check.svg/" alt="">
                    </button>
                </div>
            </div>`
        }

        return
    }

    listaSolicitacoes.style.justifyContent = 'center'
    listaSolicitacoes.style.paddingTop = '0'
    listaSolicitacoes.textContent = 'Nenhum viajante solicitou entrar no seu mundo'
})