const signUpButton = document.querySelector("#register-button")
const modal = document.querySelector("#verificationCode")
const modalButton = modal.querySelector(".modal-footer button")
const registerForm = document.querySelector("form")

signUpButton.addEventListener("click", (e) => {
    e.preventDefault()

    const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/g // deve conter caracteres antes do @, depois do @, pelo menos um ponto e entre 2 a 4 caracteres depois do ponto
    const passwordRegex = /^(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[$*&@#._/;!+-])(?!.*\s).{8,25}$/  // deve conter entre 8 a 25 caracteres, letras maiúsculas e minúsculas, números e pode ter caracteres especiais
    const inputsArray = registerForm.querySelectorAll('.input-wrapper input')
    const passwordInput = registerForm.querySelector('#password-input')
    const verifyPasswordInput = registerForm.querySelector('#verify-password-input')
    const email = document.querySelector("#email-input")

    /* 
        /^
            (?=.*\d)              // deve conter ao menos um dígito
            (?=.*[a-z])           // deve conter ao menos uma letra minúscula
            (?=.*[A-Z])           // deve conter ao menos uma letra maiúscula
            (?=.*[$*&@#._/;!+-])  // deve conter ao menos um caractere especial
            (?!.*\s)              // Não pode conter espaço
            {8,25}                // deve conter entre 8 a 25 caracteres
        $/
    */

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
    
    if (!emailRegex.test(email.value)) {
        showAlert(email, "Insira um e-mail válido")
        return
    }

    if (!passwordRegex.test(passwordInput.value)) {
        showAlert(passwordInput, "Sua senha deve conter entre 8 a 25 caracteres, letras maiúsculas e minúsculas, números e deve possuir caracteres especiais")
        return
    }
    
    if (passwordInput.value !== verifyPasswordInput.value) {
        showAlert(passwordInput, "As senhas não correspondem")
        showAlert(verifyPasswordInput, "As senhas não correspondem")
        
        return
    }

    const form = {
        email: email.value
    }

    $.post("/api/cadastro/", form, (data, status) => {
        // exibe o modal de preencher o código de verificação
        if (data.sucess) {
            const modalEmailSpanTag = modal.querySelector(".modal-body > span")

            modalEmailSpanTag.textContent = form.email

            $(modal).modal("show")
        }
    })
})

modalButton.addEventListener("click", (e) => {
    e.preventDefault()

    const verificationCodeInput = modal.querySelector("#verification-code-input")
    const form = {
        "verification-code": verificationCodeInput.value
    }
    const modalErrorText = document.querySelector('.modal-content #modal-error-text')

    modalErrorText.textContent = ''
    verificationCodeInput.style.boxShadow = "none"
    
    // envia a requisição para o back-end (que verifica se o código inserido está correto)
    $.post("/api/verify_code/", form, (data, status) => {
        if (data.sucess) {
            return registerForm.submit()
        }

        verificationCodeInput.style.boxShadow = "0px 0px 8px red"
        modalErrorText.textContent = 'O código que você inseriu está incorreto. Por favor, tente novamente.'
    })
})
