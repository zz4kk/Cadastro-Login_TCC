<?php
include 'pdo.php'; // Inclui o arquivo de conexão

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['username']) && isset($_POST['email']) && isset($_POST['password'])) {
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    if ($conn) {
        // Verifica se o e-mail já está cadastrado
        $stmt = $conn->prepare("SELECT * FROM Login_cadastro WHERE ds_email = :email");
        $stmt->bindParam(':email', $email);
        $stmt->execute();
        
        if ($stmt->rowCount() > 0) {
            echo "E-mail já cadastrado!";
            exit();
        }

        // Hash da senha
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

        // SQL para inserir um novo registro na tabela Login_cadastro
        $sql = "INSERT INTO Login_cadastro (nm_usuario, ds_email, ds_password) VALUES (:username, :email, :password)";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':username', $username);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':password', $hashedPassword);

        if ($stmt->execute()) {
            echo "Cadastro realizado com sucesso!";
        } else {
            echo "Erro ao realizar cadastro.";
        }
    } else {
        echo "Falha na conexão com o banco de dados.";
    }
} else {
    echo "Dados incompletos.";
}

// Fechar a conexão
$conn = null;
?>
