<?php

    $server = "localhost:3307";
    $user = "root";
    $password = "";
    $db = "dungeonsguild";
    
    if (
        !isset($_POST['nome']) ||
        !isset($_POST['apelido']) ||
        !isset($_POST['email']) ||
        !isset($_POST['senha']) ||
        !isset($_POST['verification-code'])
    ) {
        header('Location: http://127.0.0.1:5000/cadastro/');
    }

    $nome = $_POST['nome'];
    $apelido = $_POST['apelido'];
    $email = $_POST['email'];
    $senha = $_POST['senha'];
    $user_code = $_POST['verification-code'];
    $senha = $_POST['senha'];


    // cria a conexão
    $con = mysqli_connect($server, $user, $password, $db);

    // verifica a conexão
    if (!$con) {
        die("Connection failed: " . mysqli_connect_error());
    }

    print("Nome: $nome");
    print("apelido: $apelido");
    print("email: $email");
    print("senha: $senha");
    print("code: $code");
    print_r($_SESSION);

    // $sql = "INSERT INTO `cadastro`
    // (`nome_cadastro`, `apelido_cadastro`, `email_cadastro`, `senha_cadastro`, `id_assinatura`)
    // VALUES ('$nome', '$apelido', '$email', '$senha', 1)";

    // $insert = mysqli_query($con, $sql); # realiza a inserção do cadastro no banco
    
    // header('Location: http://127.0.0.1:5000/login/');
    exit();