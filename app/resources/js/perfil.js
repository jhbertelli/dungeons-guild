const toggleModalArray = document.querySelectorAll('[data-bs-toggle="modal"]')
const changeEmailForm = document.querySelector('#alterarEmail')
const changeEmailButton = changeEmailForm.querySelector('button')

function formatTime(time) {
    // transforma a data da API de YYYY/MM/DD para DD/MM/YYYY
    time = time.split(' ')
    let date = time[0].split('-')
    
    date = date[2] + '/' + date[1] + '/' + date[0]
    return date
}

$.getJSON("/api/perfil_usuario/", (json) => {
    const mainData = document.querySelectorAll('.personal-data td span')

    mainData[0].textContent = json['nome']
    mainData[1].textContent = json['email']

    const myStats = document.querySelectorAll('.stats-inner > div > span')

    myStats[0].textContent = json['quant_personagem']
    myStats[2].textContent = formatTime(json['data_conta'])
})


for (let i = 0; i < toggleModalArray.length; i++) {
    const toggleModal = toggleModalArray[i]
    const target = toggleModal.getAttribute('data-bs-target')
    
    toggleModalArray[i].addEventListener('click', () => {
        const modalInput = document.querySelector(target + " input")
        
        modalInput.closest('.modal').addEventListener('shown.bs.modal', () => {
            modalInput.focus()
        })
    })
}

changeEmailButton.addEventListener('click', (e) => {
    e.preventDefault()

    const email = changeEmailForm.querySelector('')
})