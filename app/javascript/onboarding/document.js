import { toggleAlert } from './erro.js';

const cnpj = document.getElementById("cnpj")
const nomeFantasia = document.getElementById("nome-fantasia")
const razaoSocial = document.getElementById("razao-social")
const textError = document.getElementById("erros")


export function verificaCNPJ(cnpj) {
    const cnpjLimpo = cnpj.replace(/\D/g, '');
    const cnpjFormatado = cnpjLimpo.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5');
    return searchCNPJ(cnpjLimpo, cnpjFormatado)
}

async function searchCNPJ(cnpjInput, cnpjFormatado) {
    try {
        let queryCNPJ = await fetch(`https://publica.cnpj.ws/cnpj/${cnpjInput}`)

        if (queryCNPJ.status === 429) {
            const errorDetails = (await queryCNPJ.json()).detalhes;
            throw Error(`${errorDetails}`);
        } else {    
            if (queryCNPJ.status === 400) {
                const errorDetails = (await queryCNPJ.json()).detalhes;
                throw Error(`${errorDetails}`);
            } else {
                textError.classList.add("hidden")
                let queryCNPJConverted = await queryCNPJ.json()
                cnpj.value = cnpjFormatado;
                razaoSocial.value = queryCNPJConverted.razao_social;
                razaoSocial.readOnly = true;
                nomeFantasia.value = queryCNPJConverted.estabelecimento.nome_fantasia;
                nomeFantasia.readOnly = true;
            }
        }

        return true;
    } catch (erro) {
        clear()
        textError.classList.remove("hidden")
        textError.innerHTML = erro.message
        return false;
    }
}

function clear() {
    cnpj.value = ''
    nomeFantasia.value = ''
    razaoSocial.value = ''
}