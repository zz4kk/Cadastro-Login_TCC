CREATE TABLE Login_cadastro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nm_usuario VARCHAR(255) NOT NULL,
    ds_email VARCHAR(255) UNIQUE NOT NULL,
    ds_password VARCHAR(255) NOT NULL
);
