function verificaSenha(campo) {
    const senhaInput = document.getElementById("senha");
    const confirmaSenhaInput = document.getElementById("confirma-senha");

    const senhaLength = document.getElementById("senhaLength");
    const senhaCapital = document.getElementById("senhaCapital");
    const senhaNumber = document.getElementById("senhaNumber");
    const senhaSymbol = document.getElementById("senhaSymbol");

    const senha = senhaInput.value;
    const confirmaSenha = confirmaSenhaInput.value;

    const senhaLengthValidation = senha.length >= 8;
    const senhaCapitalValidation = /[A-Z]/.test(senha);
    const senhaNumberValidation = /\d/.test(senha);
    const senhaSymbolValidation = /[^a-zA-Z0-9]/.test(senha);

    function applyValidationColor(validation, element, index) {
        element.classList.remove('text-red-600');
        element.classList.remove('text-green-600');

        if (validation) {
            element.classList.add('text-green-300');
            document.getElementById(`iconVermelho${index}`).classList.add("hidden");
            document.querySelector(`.iconVerde${index}`).classList.remove("hidden");
        } else {
            element.classList.add('text-red-600');
            document.getElementById(`iconVermelho${index}`).classList.remove("hidden");
            document.querySelector(`.iconVerde${index}`).classList.add("hidden");
        }
    }

    try {
        if (campo === "senha") {
            applyValidationColor(senhaLengthValidation, senhaLength, 1);
            applyValidationColor(senhaCapitalValidation, senhaCapital, 2);
            applyValidationColor(senhaNumberValidation, senhaNumber, 3);
            applyValidationColor(senhaSymbolValidation, senhaSymbol, 4);
            if (!(senhaLengthValidation && senhaCapitalValidation && senhaNumberValidation && senhaSymbolValidation)) {
                throw new Error("A senha deve ter pelo menos 8 caracteres, incluir pelo menos 1 letra maiúscula, 1 número e 1 caractere especial.");
            }
        }

        if (campo === "confirma-senha" && (senha !== confirmaSenha)) {
            throw new Error("A senha e a confirmação de senha não coincidem. Por favor, verifique.")
        }

        if (senha && confirmaSenha) {
            return true;
        } else {
            return false;
        }

    } catch (error) {
        return false;
    }
}

export { verificaSenha };