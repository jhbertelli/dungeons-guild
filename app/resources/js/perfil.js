const toggleModalArray = document.querySelectorAll('[data-bs-toggle="modal"]')

const changeNicknameForm = document.querySelector("#alterarApelido")
const nicknameInput = changeNicknameForm.querySelector(".modal-body input")

const changeNameForm = document.querySelector("#alterarNome")
const nameInput = changeNameForm.querySelector(".modal-body input")

const changeEmailForm = document.querySelector("#alterarEmail")
const changeEmailButton = changeEmailForm.querySelector(".modal-footer button")
const emailInput = changeEmailForm.querySelectorAll(".modal-body input")[0]
const passwordInput = changeEmailForm.querySelectorAll(".modal-body input")[1]

const validateInputValue = (e) => {
    // verifica se o valor do input está vazio e deixa o input vermelho com uma mensagem abaixo
    const input = e.target
    const smallText = input.parentElement.lastElementChild

    smallText.textContent = ""
    input.style.boxShadow = "none"
    input.style.outline = "none"

    if (input.value === "") {
        input.style.boxShadow = "0px 0px 8px red"
        input.style.outline = "solid 1px red"
        smallText.textContent = "Preencha este campo"
    }
}

function formatTime(time) {
    // transforma a data da API de YYYY/MM/DD para DD/MM/YYYY
    time = time.split(" ")
    let date = time[0].split("-")

    date = date[2] + "/" + date[1] + "/" + date[0]
    return date
}

nicknameInput.addEventListener("input", validateInputValue)
nameInput.addEventListener("input", validateInputValue)
emailInput.addEventListener("input", validateInputValue)
passwordInput.addEventListener("input", validateInputValue)

$.getJSON("/api/perfil_usuario/", (json) => {
    // preenche os dados do usuário
    const mainData = document.querySelectorAll(".personal-data td span")
    const myStats = document.querySelectorAll(".stats-inner > div > span")

    mainData[0].textContent = json["nome"]
    mainData[1].textContent = json["email"]

    myStats[0].textContent = json["quant_personagem"]
    myStats[2].textContent = formatTime(json["data_conta"])
})

for (let i = 0; i < toggleModalArray.length; i++) {
    const toggleModal = toggleModalArray[i]
    const target = toggleModal.getAttribute("data-bs-target")

    toggleModalArray[i].addEventListener("click", () => {
        const modalInput = document.querySelector(target + " input")
        // deixa focado no primeiro input do modal, ao ser exibido
        modalInput.closest(".modal").addEventListener("shown.bs.modal", () => {
            modalInput.focus()
        })
    })
}

changeEmailButton.addEventListener("click", (e) => {
    e.preventDefault()

    function validateInput(input) {
        // previne de enviar o formulário se o usuário clicou diretamente no botão de enviar, sem inserir dados
        const smallText = input.parentElement.lastElementChild

        smallText.textContent = ""
        input.style.boxShadow = "none"
        input.style.outline = "none"

        if (input.value === "") {
            input.style.boxShadow = "0px 0px 8px red"
            input.style.outline = "solid 1px red"
            smallText.textContent = "Preencha este campo"

            return true
        }

        return false
    }

    const form = {
        password: passwordInput.value
    }
    const smallTexts = changeEmailForm.querySelectorAll("small")
    let emptyForm = false

    if (validateInput(passwordInput)) {
        emptyForm = true
    }

    if (validateInput(emailInput)) {
        emptyForm = true
    }

    if (emptyForm) return

    $.post("/api/verify_password/", form, (data, status) => {
        if (data.sucess) {
            return changeEmailForm.submit()
        }

        passwordInput.style.boxShadow = "0px 0px 8px red"
        passwordInput.style.outline = "solid 1px red"
        passwordInput.parentElement.lastElementChild.textContent =
            "A senha que você inseriu está incorreta"
        return
    })
})
