const inputIdiomas = document.querySelector("#idiomas-proficiencias")
const inputCaracteristicas = document.querySelector("#caracteristicas")
const inputHistoria = document.querySelector("#historia")
const inputAliados = document.querySelector("#aliados")
const inputTesouro = document.querySelector("#tesouro")
const inputEquipamentos = document.querySelector("#equipamentos")
const magiasSelect = document.querySelector(".magias select")

inputCounterAndMaxLength(inputIdiomas, 300)
inputCounterAndMaxLength(inputCaracteristicas, 500)
inputCounterAndMaxLength(inputHistoria, 2000)
inputCounterAndMaxLength(inputAliados, 200)
inputCounterAndMaxLength(inputTesouro, 200)
inputCounterAndMaxLength(inputEquipamentos, 500)

magiasSelect.addEventListener("input", () => {
    for (let i = 1; i < magiasSelect.children.length; i++) {
        // exibe claramente as seleções do usuário nos inputs de magias
        if (magiasSelect.children[i].selected) {
            magiasSelect.children[i].style.backgroundColor = "dodgerblue"
            magiasSelect.children[i].style.color = "white"
        } else {
            magiasSelect.children[i].style.backgroundColor = "white"
            magiasSelect.children[i].style.color = "#212529"
        }
    }
})

document.getElementById("level").addEventListener("input", (e) => {
    // evento que pega o valor do campo "nível"
    const bonusProficienciaInput = document.querySelector("#bonus-proficiencia")
    let level = e.target.value

    if (level < 0) e.target.value = 0
    if (level > 20) e.target.value = 20

    // verifica o nível do personagem e transforma no bônus de proficiência
    switch (true) {
        case level <= 4:
            bonusProficienciaInput.value = 2
            break
        case level <= 8:
            bonusProficienciaInput.value = 3
            break
        case level <= 12:
            bonusProficienciaInput.value = 4
            break
        case level <= 16:
            bonusProficienciaInput.value = 5
            break
        case level > 16:
            bonusProficienciaInput.value = 6
            break
    }

    const bonus = Number(document.querySelector("#bonus-proficiencia").value)
    const bonusesArray = document.querySelectorAll("#bonus")
    
    // altera os valores dos testes e perícias quando bônus de proficiência mudar, se estes estiverem marcados
    for (let i = 0; i < bonusesArray.length; i++) {
        // ciclo para as perícias e testes de cada salvaguarda
        const previousBonus = Number(bonusesArray[i].textContent)
        const test = document.querySelectorAll(`.testes-resistencia div`)[i]
        const pericias = document.querySelectorAll(`.pericias [salvaguarda="${[i + 1]}"]`)

        pericias.forEach((el) => {
            let periciasPreviousBonus = Number(
                bonusesArray[el.getAttribute("salvaguarda") - 1].textContent
            )

            if (el.closest("div").firstElementChild.checked) {
                // altera o valor da perícia com o bônus de proficiência caso esteja marcado
                if (periciasPreviousBonus == 0 && bonus == 0) {
                    return el.closest("label").lastElementChild.textContent = "0"
                }

                if (periciasPreviousBonus + bonus <= 0) {
                    el.closest("label").lastElementChild.textContent =
                        periciasPreviousBonus + bonus
                } else {
                    el.closest("label").lastElementChild.textContent =
                        "+" + (periciasPreviousBonus + bonus)
                }
            }
        })

        if (test.firstElementChild.checked) {
            let idSalvaguarda =
                test.lastElementChild.lastElementChild.getAttribute(
                    "salvaguarda"
                )

            document
                .querySelectorAll(
                    `.testes-resistencia [salvaguarda="${idSalvaguarda}"]`
                )
                .forEach((el) => {
                    // altera o valor do teste de resistência com o bônus de proficiência caso esteja marcado
                    if (previousBonus == 0 && bonus == 0) {
                        return (el.closest(
                            "label"
                        ).lastElementChild.textContent = "0")
                    }

                    if (previousBonus + bonus <= 0) {
                        el.closest("label").lastElementChild.textContent =
                            previousBonus + bonus
                    } else {
                        el.closest("label").lastElementChild.textContent =
                            "+" + (previousBonus + bonus)
                    }
                })
        }
    }
})

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
        if (imageDiv.children[0]) imageDiv.children[0].remove()
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
        if (value[0] === "0" && value.length > 1)
            event.target.value = value.slice(1)
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
    // pega todas as raças da api
    for (let i = 0; i < json.length; i++) {
        document.querySelector(
            "#racas"
        ).innerHTML += `<option value=${json[i].id_raca}>${json[i].nome_raca}</option>`
    }
})

$.getJSON("http://127.0.0.1:5000/api/tendencias", (json) => {
    // pega todas as tendências da api
    for (let i = 0; i < json.length; i++) {
        document.querySelector(
            "#tendencias"
        ).innerHTML += `<option value=${json[i].id_tendencia}>${json[i].nome_tendencia}</option>`
    }
})

$.getJSON("http://127.0.0.1:5000/api/pericias", (json) => {
    // pega todas as perícias da api
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
        document.querySelector(".magias select").innerHTML += `<option value=${
            i + 1
        }>${json[i].name} - NV ${json[i].level}</option>`
    }
})

const form = document.querySelector("form")
const sendButton = document.querySelector("button")

sendButton.addEventListener("click", (e) => {
    e.preventDefault()

    const allInputs = document.querySelectorAll("input, select, textarea")

    function emptyFieldAlert(field) {
        // rola até o campo vazio
        field.scrollIntoView({
            behavior: "smooth",
            block: "center",
            inline: "nearest"
        })

        // cria um alerta e exibe-o
        let tooltip = new bootstrap.Tooltip(field, {
            title: "Preencha este campo",
            trigger: "manual"
        })

        tooltip.show()

        setTimeout(() => {
            tooltip.hide()
        }, 4000)
    }

    for (let i = 0; i < allInputs.length; i++) {
        if (
            allInputs[i].id === "img-personagem" ||
            allInputs[i].type === "checkbox" ||
            allInputs[i].name === "magias"
        ) continue

        // verifica se os selects (exceto o de magias) estão vazios
        // e se os campos de textarea/input (exceto checkboxes) estão vazios
        if (allInputs[i].selectedIndex === 0 || allInputs[i].value === "") {
            emptyFieldAlert(allInputs[i])
            allInputs[i].focus()
            return
        }
    }

    form.submit()
})
