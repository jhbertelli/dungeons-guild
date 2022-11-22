const formButton = document.querySelector("button")
const playersAmountInput = document.querySelector('#jogadores_necessarios')

playersAmountInput.addEventListener("input", (e) => {
    const value = e.target.value
    const numberRegex = /^\d+$/
    let newValue = ""

    for (let i = 0; i < value.length; i++) {
        if (!numberRegex.test(value[i])) continue

        newValue += value[i]
    }

    if (Number(value) > 20) {
        return e.target.value = 20
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
            inline: "nearest",
        })

        // cria um alerta e exibe-o
        let tooltip = new bootstrap.Tooltip(field, {
            title: "Preencha este campo",
            trigger: "manual",
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
