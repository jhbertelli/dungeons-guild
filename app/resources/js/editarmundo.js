const formButton = document.querySelector("button")
const playersAmountInput = document.querySelector("#jogadores_necessarios")
const participantesDiv = document.querySelector(".participantes")

// pega o id do mundo pela url - 3 é a posição do id na url
const idMundo = window.location.pathname.split("/")[3]

function removeParticipant(idUsuario, element) {
    // cria uma requisição para retirar o usuário desejado do mundo

    const request = {
        idMundo,
        idUsuario
    }

    $.post("/api/mundo/remover_participante", request, (resp) => {
        // remove o elemento caso o participante seja removido com sucesso
        if (resp.sucess) {
            element.remove()
        }
        
        // caso o mundo não tenha mais participantes
        if (participantesDiv.childElementCount === 0) {
            participantesDiv.textContent = 'Sem participantes'
        }
    })
}

playersAmountInput.addEventListener("input", (e) => {
    const value = e.target.value
    const numberRegex = /^\d+$/
    let newValue = ""

    for (let i = 0; i < value.length; i++) {
        if (!numberRegex.test(value[i])) continue

        newValue += value[i]
    }

    if (Number(value) > 20) {
        return (e.target.value = 20)
    }

    e.target.value = newValue
})

formButton.addEventListener("click", (e) => {
    const form = document.querySelector("form")
    const inputsArray = document.querySelectorAll("input, textarea")
    const radioButtons = document.querySelectorAll("[type='radio']")

    function emptyFieldAlert(field) {
        // rola até o campo vazio
        field.scrollIntoView({
            behavior: "smooth",
            block: "center",
            inline: "nearest"
        })

        // cria um alerta e exibe-o
        let tooltip = new bootstrap.Tooltip(field, {
            title: "Preencha este campo",
            trigger: "manual"
        })

        tooltip.show()

        setTimeout(() => {
            tooltip.hide()
        }, 4000)
    }

    e.preventDefault()

    for (let i = 0; i < inputsArray.length; i++) {
        const input = inputsArray[i]

        if (input.type === "radio" || input.type === "file") continue

        if (input.value === "") {
            emptyFieldAlert(input)
            return
        }
    }

    if (!radioButtons[0].checked && !radioButtons[1].checked) {
        emptyFieldAlert(document.querySelector(".second-column"))
        return
    }

    form.submit()
})

document.getElementById("img-mundo").addEventListener("change", (e) => {
    // exibe a imagem que o usuário enviou
    const image = e.target.files[0]
    const reader = new FileReader()

    reader.addEventListener("load", (event) => {
        const imageDiv = document.querySelector(".img-div")
        imageDiv.style.backgroundImage = `url(${event.target.result})`
        imageDiv.style.backgroundColor = "rgba(0,0,0,0)"
        imageDiv.style.witdh = "100%"
        imageDiv.style.heigth - "100%"

        if (imageDiv.children[0]) imageDiv.children[0].remove()
    })

    reader.readAsDataURL(image)
})

$.getJSON("/api/perfil_usuario/", (json) => {
    if (json.assinatura === 1) {
        document.querySelector("#privado").setAttribute("disabled", true)
    }
})

$.getJSON(`/api/mundo/${idMundo}/`, (json) => {
    console.log(json)
    const nomeMundoInput = document.querySelector(".nome_mundo")
    const nomeMundoPopup = document.querySelector("#modal-nome-mundo")
    const temaInput = document.querySelector(".tema-input")
    const descricaoInput = document.querySelector(".descricao-textarea")
    const sistemaInput = document.querySelector("#sistema")
    const frequenciaInput = document.querySelector("#frequencia")
    const dataSessaoInput = document.querySelector("#data_sessao")
    const jogadoresNecessariosInput = document.querySelector("#jogadores_necessarios")
    const imgDiv = document.querySelector(".img-div")
    const radioButtons = document.querySelectorAll("[type='radio']")

    nomeMundoInput.value = json.nome_mundo
    nomeMundoPopup.textContent = json.nome_mundo

    temaInput.value = json.tema_mundo
    descricaoInput.value = json.descricao_mundo
    sistemaInput.value = json.sistema_mundo
    frequenciaInput.value = json.frequencia_mundo
    dataSessaoInput.value = json.data_mundo.split(" ")[0] // apenas o ano/mês/dia
    jogadoresNecessariosInput.value = json.jgdorNeces_mundo
    imgDiv.style.backgroundImage = `url(${json.imagem_mundo})`

    if (json.privacidade_mundo === 0) {
        radioButtons[0].checked = true
    } else {
        radioButtons[1].checked = true
    }

    if (json.participantes.length === 0) {
        participantesDiv.textContent = 'Sem participantes'
        return
    }

    for (let i = 0; i < json.participantes.length; i++) {
        // insere os participantes do mundo
        const participante = json.participantes[i]

        participantesDiv.innerHTML += `<div>
            <p>${participante.apelido_cadastro}</p>
            <a onclick="removeParticipant(${participante.id_usuario}, this.closest('div'))" href="#">
                <img src="/images/svg/remove-participant.svg" alt="">
            </a>
        </div>`
    }
})
