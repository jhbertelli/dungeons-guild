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

document.getElementById("img-personagem").addEventListener("change", (e) => {
    // exibe a imagem que o usuário enviou
    const image = e.target.files[0]
    const reader = new FileReader()

    reader.addEventListener("load", (event) => {
        const imageDiv = document.querySelector(".img-div")
        imageDiv.style.backgroundImage = `url(${event.target.result})`
        imageDiv.style.backgroundColor = "rgba(0,0,0,0)"
        imageDiv.style.border = "6px solid white"
        imageDiv.children[0].remove()
    })

    reader.readAsDataURL(image)
})

document.querySelector("#cor-ficha").addEventListener("input", (e) => {
    // troca a cor da ficha
    const cor = e.target.value

    document.querySelector(
        ".info-principal, .info-principal > div > div"
    ).style.background = hexToRGB(cor, 0.85)
    document.querySelector(".vida").style.background = cor
    document.querySelector(".info").style.background = hexToRGB(cor, 0.75)
})

$.getJSON("http://127.0.0.1:5000/api/classes", (json) => {
    // pega todas as classes da api
    for (let i = 0; i < json.length; i++) {
        document.querySelector(
            "#classes"
        ).innerHTML += `<option value=${json[i].id_classe}>${json[i].nome_classe}</option>`
    }
})

$.getJSON("http://127.0.0.1:5000/api/tendencias", (json) => {
    // pega todas as tendencias da api
    for (let i = 0; i < json.length; i++) {
        document.querySelector(
            "#tendencias"
        ).innerHTML += `<option value=${json[i].id_tendencia}>${json[i].nome_tendencia}</option>`
    }
})

$.getJSON("http://127.0.0.1:5000/api/salvaguardas", (json) => {
    // pega todas as salvaguardas da api
    for (let i = 0; i < json.length; i++) {
        let abv_salvaguarda = json[i].nome_salvaguarda.substring(0, 3) // abrevia a string

        document.querySelector(".pericias").innerHTML += `<div class="flex">
                <input
                    class="form-check-input"
                    type="checkbox"'
                    value="${json[i].id_pericia}"
                    id="pericia-${json[i].id_pericia}"
                />
                <label
                    class="form-check-label"
                    for="pericia-${json[i].id_pericia}"
                >
                    ${json[i].nome_pericia}
                    <span style="margin-left: 5px">(${abv_salvaguarda})</span>:
                    <span>-2</span>
                </label>
            </div>`
    }
})

$.getJSON("http://127.0.0.1:5000/api/magias", (json) => {
    // pega todas as magias da API
    for (let i = 0; i < json.length; i++) {
        document.querySelector(".magias select").innerHTML += `<option value=${
            i + 1
        }>${json[i].name} - NV ${json[i].level}</option>`
    }
})

$(document).ready(() => {
    // "pop-up" de dica ao passar o mouse por cima
    $('[data-bs-toggle="tooltip"]').tooltip()
})
