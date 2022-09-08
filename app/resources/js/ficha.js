const carouselButtons = document.querySelectorAll(".carrosel-dentro ul li")

// exibindo/ocultando elementos ao clicar nos botões no carrosel

for (let i = 0; i < 7; i++) {
    carouselButtons[i].addEventListener("click", () => {
        $(document.querySelector(".detalhes").children[i]).slideToggle(300)
    })
}

carouselButtons[7].addEventListener("click", () => {
    $(document.querySelector(".historia")).slideToggle(300)
})

carouselButtons[8].addEventListener("click", () => {
    $(document.querySelector(".aliados")).slideToggle(300)
})

carouselButtons[9].addEventListener("click", () => {
    $(document.querySelector(".tesouro")).slideToggle(300)
})

$.getJSON("../json/spells.json", (json) => {
    // pega todas as magias da API
    for (let i = 0; i < json.results.length; i++) {
        document.querySelector(".magias select").innerHTML += `<option value=${i + 1}>${json.results[i].name}</option>`
    }
})

$(document).ready(() => {
    // "pop-up" de dica ao passar o mouse por cima
    $('[data-bs-toggle="tooltip"]').tooltip()
})
