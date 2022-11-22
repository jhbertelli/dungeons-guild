const codigoForm = document.getElementById('procurarCodigo')
const submitButton = codigoForm.querySelector('.modal-footer button')
const codigoInput = codigoForm.querySelector('input')
const smallText = codigoForm.querySelector('small')

function errorMessage(message) {
    codigoInput.style.boxShadow = "0px 0px 8px red"
    codigoInput.style.outline = "solid 1px red"
    smallText.textContent = message
}

codigoInput.addEventListener('input', () => {
    if (codigoInput.value === '') return errorMessage("Preencha este campo")

    smallText.textContent = ""
    codigoInput.style.boxShadow = "none"
    codigoInput.style.outline = "none"
})

submitButton.addEventListener('click', (e) => {
    e.preventDefault()
    
    if (codigoInput.value === '') {
        errorMessage("Preencha este campo")
        return
    }

    $.get("/api/verify_world_code/" + codigoInput.value, (data, status) => {
        if (data.sucess) return codigoForm.submit()
        
        errorMessage("Você inseriu um código inválido")
    })
    
})