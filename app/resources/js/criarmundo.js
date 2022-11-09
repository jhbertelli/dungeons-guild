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

document.querySelector("#participantes").addEventListener("input", (e) => {
    const apelido = e.target.value
    const xhttp = new XMLHttpRequest()

    if (apelido === '') return

    xhttp.open("GET", "/api/usuarios/" + apelido, false)
    xhttp.send()
    console.log(JSON.parse(xhttp.responseText))
    // document.getElementById("demo").innerHTML = xhttp.responseText
})
