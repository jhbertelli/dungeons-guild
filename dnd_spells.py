import requests
import json


def main():
    # pega o json das informações gerais dos feitiços
    all_spells = requests.get('https://www.dnd5eapi.co/api/spells').json()
    complete_list = []

    for spell in all_spells['results']:
        spell_list = {}

        url = 'https://www.dnd5eapi.co' + spell['url']
        # pega informações específicas de cada feitiço
        spell_info = requests.get(url).json()

        spell_list['index'] = spell_info['index']
        spell_list['name'] = spell_info['name']
        spell_list['level'] = spell_info['level']
        spell_list['url'] = spell_info['url']

        print(spell_list)
        # adiciona as informações na lista completa
        complete_list.append(spell_list)

    file = open('file.json', 'w')
    # escreve a lista completa de feitiços no arquivo json
    file.write(json.dumps(complete_list))


if __name__ == '__main__':
    main()
