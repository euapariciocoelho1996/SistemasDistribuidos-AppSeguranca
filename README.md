# Sistema de Monitoramento de Segurança com Sensor de Proximidade

Este projeto é um sistema de segurança que utiliza um aplicativo Android com sensor de proximidade e um servidor Python para detectar intrusos e enviar alertas.

## Estrutura do Projeto

- `android/`: Contém os arquivos relacionados ao desenvolvimento do aplicativo Android.
- `assets/All/`: Pasta com recursos como imagens e outros arquivos necessários para o aplicativo.
- `lib/`: Contém bibliotecas e dependências do projeto.
- `security_images/`: Armazena as imagens capturadas durante a detecção de intrusos.
- `test/`: Pasta para os testes automatizados do projeto.
- `.gitattributes`: Arquivo de atributos do Git.
- `.gitignore`: Arquivo para ignorar arquivos desnecessários no versionamento.
- `.metadata`: Contém metadados sobre o projeto.
- `LICENSE`: Arquivo de licença do projeto.
- `README.md`: Documentação do projeto.
- `analysis_options.yaml`: Arquivo de configuração para opções de análise.
- `pubspec.lock`: Arquivo de bloqueio do pubspec para garantir a integridade das dependências.
- `pubspec.yaml`: Arquivo de configuração do projeto no Flutter.

## Requisitos

- Python 3.x
- Android Studio (para desenvolvimento Android)
- Flutter (para desenvolvimento multiplataforma)


## Instalação

### 1. Clone o repositório:

git clone https://github.com/seu-usuario/seguranca-monitoramento.git
cd seguranca-monitoramento

## 📸 Telas do Sistema

Esta seção apresenta as telas principais do **Sistema de Monitoramento de Segurança com Sensor de Proximidade**, descrevendo suas funcionalidades e incluindo imagens ilustrativas.

---

## 🖥️ Tela Inicial do Servidor

### 📌 Descrição:
A tela inicial do servidor exibe o status de conexão do servidor e o botão para parar o alarme.

### 🔹 Funcionalidades:
- Exibe se o **servidor está online** ou **offline**.
- Botão para **parar o alarme**.

### 🖼️ Imagem:

![Tela Inicial Servidor](https://github.com/user-attachments/assets/f2ac5476-bcc3-42f8-bdd7-cdc814b1f6e9)
---
![Imagem do WhatsApp de 2025-03-20 à(s) 21 45 18_d8210801](https://github.com/user-attachments/assets/7db5746a-74c3-479e-85ae-53f4364961c2)

---

## 📱 Tela Inicial do Aplicativo

### 📌 Descrição:
A tela inicial do aplicativo Android permite que o usuário ative ou desative o modo de segurança.

### 🔹 Funcionalidades:
- Botão para **ativar o modo de segurança**.
- Exibe o status do **sensor de proximidade**.

### 🖼️ Imagem:
<div align="center">
  <img src="https://github.com/user-attachments/assets/758e90de-d1d2-4f89-83eb-7286ee1bd022" alt="Tela Inicial do Aplicativo" />
</div>
---

## 🚨 Alerta de Intruso

### 📌 Descrição:
Quando o sensor de proximidade detecta movimento, o aplicativo envia um alerta para o servidor e captura uma foto do intruso.

### 🔹 Funcionalidades:
- Envio de **alerta** para o servidor.
- **Captura de imagem** do intruso e envio ao servidor.

### 🖼️ Imagem:

### 🖼️ Imagem:
<div align="center">
  <img src="https://github.com/user-attachments/assets/2b8bc963-4c90-46eb-9d9a-a70a44b75b3e" alt="Alerta de Intruso" />
</div>

---

<div align="center">
  <img src="https://github.com/user-attachments/assets/2c83079a-5ee0-4073-9799-4a0b81d309e5" alt="Alerta de Intruso 2" />
</div>
---

## 💻 Tela de Alarme do Servidor

### 📌 Descrição:
A tela do servidor exibe o alarme em execução e as imagens recebidas do aplicativo.

### 🔹 Funcionalidades:
- **Exibição do alarme** ativo.

### 🖼️ Imagem:
![Imagem do WhatsApp de 2025-03-20 à(s) 21 45 18_ef2719fc](https://github.com/user-attachments/assets/ac794fe9-65cf-4750-a0d0-ec49ae3c0fcd)

- **Exibição das imagens** capturadas do intruso.
---
![Imagem do WhatsApp de 2025-03-20 à(s) 21 45 18_f9d4d488](https://github.com/user-attachments/assets/5253a095-67cf-416b-aa8b-8b63bf135cb1)
---


