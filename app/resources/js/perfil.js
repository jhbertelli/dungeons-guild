const toggleModalArray = document.querySelectorAll('[data-bs-toggle="modal"]')
const forms = document.querySelectorAll("form")

const changeEmailForm = document.querySelector("#alterarEmail")
const changeEmailButton = changeEmailForm.querySelector(".modal-footer button")

const changePasswordForm = document.querySelector("#alterarSenha")
const changePasswordButton = changePasswordForm.querySelector(".modal-footer button")

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

const handleFormSubmit = (e) => {
    e.preventDefault()

    const form = e.target.closest("form")
    const formInputs = form.querySelectorAll(".modal-body input")
    const currentPassword = form.querySelector("#senha-atual")

    function validateInput(input) {
        // previne de enviar o formulário se o usuário clicou diretamente no botão de enviar, sem inserir dados
        const smallText = input.parentElement.lastElementChild
        const passwordRegex = /^(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[$*&@#._/;!+-])(?!.*\s).{8,25}$/  // deve conter entre 8 a 25 caracteres, letras maiúsculas e minúsculas, números e pode ter caracteres especiais
        const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/g // deve conter caracteres antes do @, depois do @, pelo menos um ponto e entre 2 a 4 caracteres depois do ponto

        smallText.textContent = ""
        input.style.boxShadow = "none"
        input.style.outline = "none"

        if (input.value === "") {
            input.style.boxShadow = "0px 0px 8px red"
            input.style.outline = "solid 1px red"
            smallText.textContent = "Preencha este campo"

            return true
        }

        if (input.type === 'email') {
            if (!emailRegex.test(input.value)) {
                input.style.boxShadow = "0px 0px 8px red"
                input.style.outline = "solid 1px red"
                smallText.textContent = "Insira um e-mail válido"
                
                return true
            }
        }

        if (input.id === 'senha-nova') {
            if (!passwordRegex.test(input.value)) {
                input.style.boxShadow = "0px 0px 8px red"
                input.style.outline = "solid 1px red"
                smallText.textContent = "Sua senha deve conter entre 8 a 25 caracteres, letras maiúsculas e minúsculas, números e deve possuir caracteres especiais"

                return true
            }
        }

        return false
    }

    const request = {
        password: currentPassword.value
    }

    const smallTexts = form.querySelectorAll("small")

    let emptyForm = false

    for (let i = 0; i < formInputs.length; i++) {
        // se algum input estiver vazio, o formulário não será enviado
        if (validateInput(formInputs[i])) emptyForm = true
    }

    if (emptyForm) return

    $.post("/api/verify_password/", request, (data, status) => {
        if (data.sucess) {
            return form.submit()
        }

        currentPassword.style.boxShadow = "0px 0px 8px red"
        currentPassword.style.outline = "solid 1px red"
        currentPassword.parentElement.lastElementChild.textContent =
            "A senha que você inseriu está incorreta"
        return
    })
}

function formatTime(time) {
    // transforma a data da API de YYYY/MM/DD para DD/MM/YYYY
    time = time.split(" ")
    let date = time[0].split("-")

    date = date[2] + "/" + date[1] + "/" + date[0]
    return date
}

changeEmailButton.addEventListener("click", handleFormSubmit)
changePasswordButton.addEventListener("click", handleFormSubmit)

for (let i = 0; i < forms.length; i++) {
    const inputs = forms[i].querySelectorAll('.modal-body input')
    for (let j = 0; j < inputs.length; j++) {
        // adiciona o validateInputValue para cada input dos formulários
        inputs[j].addEventListener("input", validateInputValue)   
    }
}

$.getJSON("/api/perfil_usuario/", (json) => {
    // preenche os dados do usuário
    const mainData = document.querySelectorAll(".personal-data td span")
    const myStats = document.querySelectorAll(".stats-inner > div > span")

    mainData[0].textContent = json["nome"]
    mainData[1].textContent = json["email"]

    myStats[0].textContent = json["quant_personagem"]
    myStats[1].textContent = json["quant_mundos"]
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