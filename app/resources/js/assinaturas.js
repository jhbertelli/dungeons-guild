const signatureCards = document.querySelectorAll(".signature-card")

signatureCards.forEach((el) => {
    // efeito de zoom ao passar em cima dos cards
    el.addEventListener("mouseover", () => {
        el.style.width = "31em"
        el.style.height = "85%"
        el.querySelector("img").style.height = "15em"
        el.querySelector("h2").style.fontSize = "2.25rem"
        el.querySelectorAll("li").forEach((li) => {
            li.style.fontSize = "16pt"
        })
        el.querySelector(".button").style.fontSize = "18px"
    })

    el.addEventListener("mouseleave", () => {
        el.style.width = "27.5em"
        el.style.height = "80%"
        el.querySelector("img").style.height = "13em"
        el.querySelector("h2").style.fontSize = "2rem"
        el.querySelectorAll("li").forEach((li) => {
            li.style.fontSize = "14pt"
        })
        el.querySelector(".button").style.fontSize = "16px"
    })
})

const modalInputs = document.querySelectorAll(".modal-body input")

for (let i = 0; i < 3; i++) {
    modalInputs[i].addEventListener("input", () => {
        const numberRegex = /^\d+$/
        
    })
}
