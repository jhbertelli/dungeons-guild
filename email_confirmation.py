import smtplib
import ssl
import os
from email.message import EmailMessage
from string import ascii_uppercase, digits
from random import choice
from dotenv import load_dotenv


def verification_code():
    chars = list(ascii_uppercase + digits)
    code = ''

    while len(code) < 6:
        code += choice(chars)

    return code


def send_confirmation(recipient, code):
    # e-mail e senha do remetente
    load_dotenv()
    sender = os.getenv("EMAIL")
    password = os.getenv("PASSWORD")

    msg = EmailMessage()

    # conteudo do e-mail
    msg.set_content(f"""Seu código de verificação do Daymeals é:

    {code}""")
    msg['Subject'] = "Código de Verificação - Dungeon's Guild"
    msg['From'] = sender
    msg['To'] = recipient  # e-mail do destinatário

    # configuracao do smtp, serviço usado para enviar o e-mail

    serv = smtplib.SMTP('smtp-mail.outlook.com', 587)
    serv.starttls(context=ssl.create_default_context())

    serv.login(sender, password)

    try:
        serv.send_message(msg)
    except:
        raise Exception('Não foi possível enviar o e-mail')

    serv.quit()

    return
