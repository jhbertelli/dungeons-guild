function formatTime(time) {
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