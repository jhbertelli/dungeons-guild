const carouselButtons = document.querySelectorAll(".carrosel-dentro ul li")

// exibindo/ocultando elementos ao clicar nos botões no carrosel

for (let i = 0; i < 7; i++) {
    carouselButtons[i].addEventListener("click", () => {
        $(document.querySelector(".detalhes").children[i]).slideToggle(300)
    })
 
    if (i < 3) { // para os detalhes de fora
        carouselButtons[i + 7].addEventListener("click", () => {
            $(document.querySelectorAll(".detalhesfora")[i]).slideToggle(300)
        })
    }
}

$.getJSON("../json/spells_sorted.json", (json) => {
    // pega todas as magias da API
    for (let i = 0; i < json.length; i++) {
        document.querySelector(".magias select").innerHTML += `<option value=${i + 1}>${json[i].name} - NV ${json[i].level}</option>`
    }
})

$(document).ready(() => {
    // "pop-up" de dica ao passar o mouse por cima
    $('[data-bs-toggle="tooltip"]').tooltip()
})
