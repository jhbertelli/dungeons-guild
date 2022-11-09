function hexToRGB(hex, alpha) {
    // função que transforma um valor hexadecimal de cor para rgba
    const r = parseInt(hex.slice(1, 3), 16),
        g = parseInt(hex.slice(3, 5), 16),
        b = parseInt(hex.slice(5, 7), 16)

    if (alpha) {
        return `rgba(${r}, ${g}, ${b}, ${alpha})`
    } else {
        return `rgb(${r}, ${g}, ${b})`
    }
}

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

$.getJSON("http://127.0.0.1:5000/api/pericias", (json) => {
    // pega todas as pericias da api
    for (let i = 0; i < json.length; i++) {
        let abv_salvaguarda = json[i].nome_salvaguarda.substring(0, 3)

        document.querySelector(".pericias").innerHTML += `<div class="flex">
            <input
                class="form-check-input"
                type="checkbox"
                value="${json[i].id_pericia}"
                name="pericias"
                id="pericia-${json[i].id_pericia}"
                onclick="return false"
            />
            <label
                class="form-check-label"
                for="pericia-${json[i].id_pericia}"
            >
                ${json[i].nome_pericia}
                <span style="margin-left: 5px" salvaguarda="${json[i].id_salvaguardas}">(${abv_salvaguarda})</span>:
                <span>0</span>
            </label>
        </div>`
    }
})

$(document).ready(() => {
    // "pop-up" de dica ao passar o mouse por cima
    $('[data-bs-toggle="tooltip"]').tooltip()
})
