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

    document.querySelector(".info-principal").style.background = hexToRGB(cor, 0.85)
    document.querySelector(".vida").style.background = cor
    document.querySelector(".info").style.background = hexToRGB(cor, 0.75)
})

document.querySelectorAll('[type="number"]').forEach((element) => {
    element.addEventListener("input", (event) => {
        let value = event.target.value

        // previne o usuário a inserir números menores que 0 em todos os inputs de número
        if (value <= 0) event.target.value = 0
        // retira o "0" do valor, caso seja maior que 0 (ex: retira o 0 de "04")
        if (value[0] === "0" && value.length > 1) event.target.value = value.slice(1)
    })
})

$(document).ready(() => {
    // "pop-up" de dica ao passar o mouse por cima
    $('[data-bs-toggle="tooltip"]').tooltip()
})

// carregamento das APIs

$.getJSON("http://127.0.0.1:5000/api/classes", (json) => {
    // pega todas as classes da api
    for (let i = 0; i < json.length; i++) {
        document.querySelector(
            "#classes"
        ).innerHTML += `<option value=${json[i].id_classe}>${json[i].nome_classe}</option>`
    }
})

$.getJSON("http://127.0.0.1:5000/api/antecedentes", (json) => {
    // pega todos os antecedentes da api
    for (let i = 0; i < json.length; i++) {
        document.querySelector(
            "#antecedentes"
        ).innerHTML += `<option value=${json[i].id}>${json[i].antecedente}</option>`
    }
})

$.getJSON("http://127.0.0.1:5000/api/racas", (json) => {
    // pega todas as racas da api
    for (let i = 0; i < json.length; i++) {
        document.querySelector(
            "#racas"
        ).innerHTML += `<option value=${json[i].id_raca}>${json[i].nome_raca}</option>`
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

$.getJSON("http://127.0.0.1:5000/api/pericias", (json) => {
    // pega todas as salvaguardas da api
    for (let i = 0; i < json.length; i++) {
        let abv_salvaguarda = json[i].nome_salvaguarda.substring(0, 3) // abrevia a string

        document.querySelector(".pericias").innerHTML += `<div class="flex">
            <input
                class="form-check-input"
                type="checkbox"
                value="${json[i].id_pericia}"
                name="pericias"
                id="pericia-${json[i].id_pericia}"
                oninput="addBonusToPericias(this, ${json[i].id_salvaguardas})"
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

$.getJSON("http://127.0.0.1:5000/api/magias", (json) => {
    // pega todas as magias da API
    for (let i = 0; i < json.length; i++) {
        document.querySelector(".magias select").innerHTML += `<option value=${i + 1}>${
            json[i].name
        } - NV ${json[i].level}</option>`
    }
})
