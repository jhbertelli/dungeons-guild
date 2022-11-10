const signUpButton = document.querySelector("#register-button")
const modal = document.querySelector("#verificationCode")
const modalButton = modal.querySelector(".modal-footer button")
const registerForm = document.querySelector("form")

signUpButton.addEventListener("click", (e) => {
    e.preventDefault()
    
    const inputsArray = registerForm.querySelectorAll('.input-wrapper input')
    
    function showAlert(field, text) {
        field.scrollIntoView({
            behavior: "smooth",
            block: "center",
            inline: "nearest"
        })
    
        // cria um alerta
        let tooltip = new bootstrap.Tooltip(field.parentElement, {
            title: text,
            trigger: "manual"
        })
    
        // exibe o alerta
        tooltip.show()
    
        setTimeout(() => {
            tooltip.hide()
        }, 4000)
    }

    for (let i = 0; i < inputsArray.length; i++) {
        const input = inputsArray[i]
        
        // cria um alerta caso algum campo não seja preenchido
        if (input.value === '') {
            showAlert(input, "Preencha este campo")
            return
        }
    }

    const passwordInput = registerForm.querySelector('#password-input')
    const verifyPasswordInput = registerForm.querySelector('#verify-password-input')

    if (passwordInput.value !== verifyPasswordInput.value) {
        showAlert(passwordInput, "As senhas não correspondem")
        showAlert(verifyPasswordInput, "As senhas não correspondem")
        
        return
    }

    const email = document.querySelector("#email-input")
    const form = {
        email: email.value
    }

    $.post("/api/cadastro/", form, (data, status) => {
        // exibe o modal de preencher o código de verificação
        if (data) {
            const modalEmailSpanTag = modal.querySelector(".modal-body > span")

            modalEmailSpanTag.textContent = form.email

            $(modal).modal("show")
        }
    })
})

modalButton.addEventListener("click", () => {
    const verificationCode = modal.querySelector("#verification-code-input").value
    const form = {
        "verification-code": verificationCode
    }

    $.post("/api/verify_code/", form, (data, status) => {
        if (data.sucess) {
            registerForm.submit()
        }
    })
})
