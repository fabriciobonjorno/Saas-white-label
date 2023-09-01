import { toggleAlert, createAlert } from './erro.js';

function verificaCamposDoFormulario(campo) {
    const nomeInput = document.getElementById("nome");
    const usernameInput = document.getElementById("username");
    const emailInput = document.getElementById("email");

    const nome = nomeInput.value.trim();
    const username = usernameInput.value.trim();
    const email = emailInput.value.trim();

    try {
        if (campo === "nome" && (!nome || nome.length < 3)) {
            nomeInput.value = ''
            throw new Error("O campo 'Nome' deve conter pelo menos 3 caracteres.");
        }

        if (campo === "username" && (!/^[a-zA-Z0-9_-]+$/.test(username))) {
            usernameInput.value = ''
            throw new Error("O campo 'Username' não pode conter espaços e deve usar apenas '_', '-' ou caracteres alfanuméricos.");
        }

        if (campo === "email" && (!email || !isValidEmail(email))) {
            emailInput.value = ''
            throw new Error("Por favor, insira um endereço de email válido.");
        }

        if (nome, username, email) {
            return true;
        } else {
            return false
        }

    } catch (error) {
        createAlert();
        toggleAlert(true, error.message);
        return false;
    }
}

function isValidEmail(email) {
    const regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    return regex.test(email);
}

export { verificaCamposDoFormulario };