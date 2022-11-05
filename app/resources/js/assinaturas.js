$.getJSON("/api/perfil_usuario/", (json) => {
    const paidVersionCard = document.getElementsByClassName("signature-card")[1]

    if (json["assinatura"] === 1) {
        paidVersionCard.setAttribute("data-bs-toggle", "modal")
        paidVersionCard.setAttribute("data-bs-target", "#pagamento")

        return
    }

    document.querySelector("form").remove()
    paidVersionCard.lastElementChild.textContent = "Já Adquirido"
})

const signatureCards = document.querySelectorAll(".signature-card")

signatureCards.forEach((el) => {
    // efeito de zoom ao passar em cima dos cards
    el.addEventListener("mouseover", () => {
        el.style.width = "31em"
        el.style.height = "85%"
        el.querySelector("img").style.height = "15em"
        el.querySelector("h2").style.fontSize = "2rem"
        el.querySelectorAll("li").forEach((li) => {
            li.style.fontSize = "15pt"
        })
        el.querySelector(".button").style.fontSize = "18px"
    })

    el.addEventListener("mouseleave", () => {
        el.style.width = "27.5em"
        el.style.height = "80%"
        el.querySelector("img").style.height = "13em"
        el.querySelector("h2").style.fontSize = "1.75rem"
        el.querySelectorAll("li").forEach((li) => {
            li.style.fontSize = "13pt"
        })
        el.querySelector(".button").style.fontSize = "16px"
    })
})

const modalInputs = document.querySelectorAll(".modal-body input")

const validateNumber = (el) => {
    // previne o usuário a inserir letra no input de nº do cartão e cód. segurança
    const value = el.target.value
    const numberRegex = /^\d+$/
    let newValue = ""

    for (let i = 0; i < value.length; i++) {
        if (!numberRegex.test(value[i])) continue

        newValue += value[i]
    }

    el.target.value = newValue
}

modalInputs[0].addEventListener("input", validateNumber)
modalInputs[2].addEventListener("input", validateNumber)
