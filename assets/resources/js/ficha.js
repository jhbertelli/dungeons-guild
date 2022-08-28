const carouselButtons = document.querySelectorAll('.carrosel-dentro ul li')

for (let i = 0; i < 4; i++) {
    carouselButtons[i].addEventListener('click', () => {
        $(document.querySelectorAll('section')[0].children[i]).slideToggle(300)
    })
    carouselButtons[i + 4].addEventListener('click', () => {
        $(document.querySelectorAll('section')[1].children[i]).slideToggle(300)
    })
}

carouselButtons[8].addEventListener('click', () => {
    $(document.querySelector('.historia')).slideToggle(300)
})
