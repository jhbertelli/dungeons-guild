<?php

    $server = "localhost:3307";
    $user = "root";
    $password = "";
    $db = "dungeonsguild";

    $nome = $_POST['nome'];
    $apelido = $_POST['apelido'];
    $email = $_POST['email'];
    $senha = $_POST['senha'];

    // cria a conexão
    $con = mysqli_connect($server, $user, $password, $db);

    // verifica a conexão
    if (!$con) {
        die("Connection failed: " . mysqli_connect_error());
    }

    $sql = "INSERT INTO `cadastro`
    (`nome_cadastro`, `apelido_cadastro`, `email_cadastro`, `senha_cadastro`)
    VALUES ('$nome', '$apelido', '$email', '$senha')";

    $insert = mysqli_query($con, $sql); # realiza a inserção do cadastro no banco
    
    header('Location: http://127.0.0.1:5000/login/');
    exit();