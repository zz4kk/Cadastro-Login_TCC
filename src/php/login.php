<?php
session_start();
include 'pdo.php';

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['nome']) && isset($_POST['senha'])) {
    $nome = $_POST['nome'];
    $senha = $_POST['senha'];

    if ($conn) {
        $stmt = $conn->prepare("SELECT * FROM Login_cadastro WHERE nm_usuario = :nome");
        $stmt->bindParam(':nome', $nome);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            if (password_verify($senha, $user['ds_password'])) {
                $_SESSION['nome'] = $nome;
                echo "1"; // Sucesso
            } else {
                echo "0"; // Senha inválida
            }
        } else {
            echo "0"; // Usuário não encontrado
        }
    } else {
        echo "Falha na conexão com o banco de dados.";
    }
} else {
    echo "Dados incompletos.";
}

$conn = null;
?>
