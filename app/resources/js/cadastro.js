const button = document.querySelector("#register-button")

button.addEventListener("click", (e) => {
    e.preventDefault()

    const email = document.querySelector("#email-input")
    // const xhttp = new XMLHttpRequest()
    const form = {
        email: email.value,
    }

    $.post("/api/cadastro/", form, (data, status) => {
        if (data) {
            
        }
    })
})
