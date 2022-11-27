const modalCharacterNameTag = document.querySelector(".modal-body #nome-mundo")
const modalCharacterValue = document.querySelector(".modal-footer input")
const codigoForm = document.getElementById('procurarCodigo')
const submitButton = codigoForm.querySelector('.modal-footer button')
const codigoInput = codigoForm.querySelector('input')
const smallText = codigoForm.querySelector('small')
const modal = document.querySelector(".modal")

modal.addEventListener("hide.bs.modal", () => {
    setTimeout(() => {
        modalCharacterNameTag.textContent = ""
        modalCharacterValue.value = ""
    }, 150)
})

function errorMessage(message) {
    // exibe uma mensagem de erro no input abaixo, trocando a cor do input também
    codigoInput.style.boxShadow = "0px 0px 8px red"
    codigoInput.style.outline = "solid 1px red"
    smallText.textContent = message
}

function redirect(el, id) {
    console.log(el, id)
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

    // envia o código digitado pelo usuário para o back-end, que verifica se há algum mundo privado com esse código
    $.get("/api/verify_world_code/" + codigoInput.value, (data, status) => {
        if (data.sucess) return codigoForm.submit()
        
        errorMessage("Você inseriu um código inválido")
    })
    
})

$.getJSON("/api/mundos/", async (json) => {
    await $.getJSON("/api/perfil_usuario/", (usuario) => {
        const myWorldsTag = document.querySelector('.meus-mundos')
        const communityWorldsTag = document.querySelector('.mundos-comunidade')
        const createButton = myWorldsTag.firstElementChild
        
        let myWorldsArray = []
        let enteredWorldsArray = []

        if (usuario.assinatura === 1) {
            if (usuario.quant_mundos === 0) {
                createButton.lastElementChild.textContent = 'Criar mundo'
                createButton.setAttribute('href', '/criar/mundo/')
            } else {
                createButton.style.fontSize = '1.25em'
                createButton.lastElementChild.textContent = 'Se você deseja viajar em mais mundos, você precisa de uma assinatura!'
                createButton.setAttribute('href', '/assinaturas/')
            }
        } else {
            createButton.lastElementChild.textContent = 'Criar mundo'
            createButton.setAttribute('href', '/criar/mundo/')
        }
        
        class createWorldHTML {
            constructor(world, owner) {
                this.html = `<div class="card-mundo" onclick="window.location = '/mundo/' + ${world.id_mundo}">
                    <img src="${world.imagem_mundo}" alt="" />
                    <div class="desc">
                        <div class="nome-mundo" style="${owner ? '' : 'justify-content: center;'}">
                            ${owner ? `<a href="/editar/mundo/${world.id_mundo}/" class="edit-button">
                                <img src="/images/svg/pencil.svg" alt="">
                            </a>` : ''}
                            
                            <h3>${world.nome_mundo}</h3>
                            ${owner ? `<a style="width: 32px">
                                <div></div>
                            </a>` : ''}
                        </div>
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

                return this
            }
        }
        
        
        for (let i = 0; i < json.length; i++) {
            // pega todos os mundos visíveis pelo usuário e os filtra
            const world = json[i]
            const worldHTML = new createWorldHTML(world, false)
            
            if (world.dono) {
                // verifica se o usuário é o dono do mundo e pula
                myWorldsArray.push(world)
                continue
            }
            
            if (world.participa) {
                // verifica se o usuário participa do mundo e pula
                enteredWorldsArray.push(world)
                continue
            }
            
            // adiciona o mundo para o campo de "Mundos da comunidade"
            communityWorldsTag.innerHTML += worldHTML.html

            const thisCard = communityWorldsTag.lastElementChild

            thisCard.addEventListener('click', () => {
                window.location = "/mundo/" + world.id_mundo
            })
        }
        for (let i = 0; i < myWorldsArray.length; i++) {
            // adiciona os mundos criados pelo usuário no campo "Meus mundos"
            const world = myWorldsArray[i]
            const worldHTML = new createWorldHTML(world, true)
            
            myWorldsTag.innerHTML += worldHTML.html
        }
        
        for (let i = 0; i < enteredWorldsArray.length; i++) {
            // adiciona os mundos que o usuário participa no campo "Meus mundos"
            const world = enteredWorldsArray[i]
            const worldHTML = new createWorldHTML(world, false)
            
            myWorldsTag.innerHTML += worldHTML.html
        }
    })
})
