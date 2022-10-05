const carouselButtons = document.querySelectorAll(".carrosel-dentro ul li")

// exibindo/ocultando elementos ao clicar nos botões no carrosel
for (let i = 0; i < 7; i++) {
    carouselButtons[i].addEventListener("click", () => {
        $(document.querySelector(".detalhes").children[i]).slideToggle(300)
    })

    if (i < 3) {
        // para os detalhes de fora
        carouselButtons[i + 7].addEventListener("click", () => {
            $(document.querySelectorAll(".detalhesfora")[i]).slideToggle(300)
        })
    }
}

$.getJSON("http://127.0.0.1:5000/api/magias", (json) => {
    // pega todas as magias da API
    for (let i = 0; i < json.length; i++) {
        document.querySelector(".magias select").innerHTML += `<option value=${
            i + 1
        }>${json[i].name} - NV ${json[i].level}</option>`
    }
})

$.getJSON("http://127.0.0.1:5000/api/salvaguardas", (json) => {
    // pega todas as salvaguardas da api
    for (let i = 0; i < json.length; i++) {
        let abv_salvaguarda = json[i].nome_salvaguarda.substring(0, 3)

        document.querySelector(".pericias").innerHTML += `<div class="flex">
            <input
                class="form-check-input"
                type="checkbox"
                value=""
                id="flexCheckDefault"
                onclick="return false"
            />
            <label
                class="form-check-label"
                for="flexCheckDefault"
            >
                ${json[i].nome_pericia}
                <span style="margin-left: 5px">(${abv_salvaguarda})</span>:
                <span>-2</span>
            </label>
        </div>`
    }
})

$(document).ready(() => {
    // "pop-up" de dica ao passar o mouse por cima
    $('[data-bs-toggle="tooltip"]').tooltip()
})
