const cepInput = document.getElementById("cep");
const rua = document.getElementById("rua");
const numero = document.getElementById("numero");
const estado = document.getElementById("estado");
const cidade = document.getElementById("cidade");
const bairro = document.getElementById("bairro");
const textError = document.getElementById("erros")

export async function verificaCEP(cep, numero) {
    const cepLimpo = cep.replace(/\D/g, '');
    const cepFormatado = cepLimpo.replace(/(\d{5})(\d{3})/, '$1-$2');

    try {

        if (!(/^\d+$/.test(cepLimpo))) {
            clear();
            textError.classList.remove("hidden")
            textError.innerHTML = "Por favor, preencha o campo do CEP somente com números!"
            return false;
        } else {
            textError.classList.add("hidden")
        }
        
        if (cepLimpo.length < 8) {
            clear();
            textError.classList.remove("hidden")
            textError.innerHTML = "Por favor, preencher o campo do CEP com 8 números!"
            return false;
        } else {
            textError.classList.add("hidden")
        }

        const consultaCEP = await fetch(`https://viacep.com.br/ws/${cepLimpo}/json/`);
        const consultaCEPConvertida = await consultaCEP.json();
        if (consultaCEPConvertida.erro) {
            clear();
            textError.classList.remove("hidden")
            textError.innerHTML = "CEP não encontrado!"
            return false;
        } else {
            textError.classList.add("hidden")
        }

        cepInput.value = cepFormatado;
        rua.value = consultaCEPConvertida.logradouro;
        rua.readOnly = true;
        bairro.value = consultaCEPConvertida.bairro;
        bairro.readOnly = true;
        cidade.value = consultaCEPConvertida.localidade;
        cidade.readOnly = true;
        estado.value = consultaCEPConvertida.uf;
        estado.readOnly = true;

        if (!numero || numero.trim() === '') {
            return false;
        } else {
            return true
        }

    } catch (error) {
        clear();
        textError.classList.remove("hidden")
        textError.innerHTML = error.message
        return false;
    }
}

function clear() {
    cepInput.value = '';
    rua.value = '';
    estado.value = '';
    cidade.value = '';
    bairro.value = '';
    numero.value = '';
}