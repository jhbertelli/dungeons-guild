const codigoForm = document.getElementById('procurarCodigo')
const submitButton = codigoForm.querySelector('.modal-footer button')
const codigoInput = codigoForm.querySelector('input')
const smallText = codigoForm.querySelector('small')

function errorMessage(message) {
    codigoInput.style.boxShadow = "0px 0px 8px red"
    codigoInput.style.outline = "solid 1px red"
    smallText.textContent = message
}

codigoInput.addEventListener('input', () => {
    if (codigoInput.value === '') return errorMessage("Preencha este campo")

    smallText.textContent = ""
    codigoInput.style.boxShadow = "none"
    codigoInput.style.outline = "none"
})

submitButton.addEventListener('click', (e) => {
    e.preventDefault()
    
    if (codigoInput.value === '') {
        errorMessage("Preencha este campo")
        return
    }

    $.get("/api/verify_world_code/" + codigoInput.value, (data, status) => {
        if (data.sucess) return codigoForm.submit()
        
        errorMessage("Você inseriu um código inválido")
    })
    
})

$.getJSON("/api/mundos/", async (json) => {
    await $.getJSON("/api/perfil_usuario/", (usuario) => {
        const meusMundos = document.querySelector('.meus-mundos')
        
        if (usuario.assinatura === 1) {
            if (usuario.quant_mundos === 0) {
                meusMundos.innerHTML += `<a href="/criar/mundo" class="criar-mundo">
                    <img src="/images/svg/plus-icon.svg" alt="" />
                    <span>Criar Mundo</span>
                </a>`
            }
        } else {
            meusMundos.innerHTML += `<a href="/criar/mundo" class="criar-mundo">
                <img src="/images/svg/plus-icon.svg" alt="" />
                <span>Criar Mundo</span>
            </a>`
        }
        
        for (let i = 0; i < json.length; i++) {
            const world = json[i]
            
            if (world.dono) {
                console.log(world)
                meusMundos.innerHTML += `<div class="card-mundo">
                    <img src="${world.imagem_mundo}" alt="" />
                    <div class="desc">
                        <h3>${world.nome_mundo}</h3>
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
        }
    })

})
