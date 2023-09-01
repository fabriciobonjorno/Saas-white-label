import { verificaCEP } from './cep.js';
import { verificaCNPJ } from './cnpj.js';
import { verificaCamposDoFormulario } from './register.js'
import { maskInput } from './contato.js'

import { verificaSenha } from './senha.js';
const textError = document.getElementById("erros")

const stepValidations = [false, false, false, false];

document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("multi-step-form");
    const steps = form.querySelectorAll(".step");
    const nextButtons = form.querySelectorAll(".next-step");
    const prevButtons = form.querySelectorAll(".prev-step");
    let currentStep = 0;

    function showStep(stepNumber) {
        steps.forEach((step) => {
            step.style.display = "none";
        });

        steps[stepNumber].style.display = "block";
    }

    nextButtons.forEach((button) => {
        button.addEventListener("click", function (e) {
            e.preventDefault();
            if (stepValidations[currentStep]) {
                currentStep++;
                showStep(currentStep);
                let itensLineId = '#lineIcon' + currentStep
                let itensTextId = '#iconText' + currentStep
                let itensLine = document.querySelector(itensLineId)
                let itensText = document.querySelector(itensTextId)
                textError.classList.add("hidden")
                itensLine.classList.add("activeCard");
                itensText.classList.add("active");
            } else {
                if (currentStep === 1) {
                    textError.classList.remove("hidden")
                    textError.innerHTML = `O campo numero não foi preenchido corretamente!`;
                } else {
                    textError.classList.remove("hidden")
                    textError.innerHTML = `Passo ${currentStep + 1} não foi preenchido corretamente!`;
                }
            }
        });
    });

    prevButtons.forEach((button) => {
        button.addEventListener("click", function (e) {
            e.preventDefault();
            currentStep--;
            showStep(currentStep);

            let itensLineId = '#lineIcon' + (currentStep + 1)
            let itensTextId = '#iconText' + (currentStep + 1)
            let itensLine = document.querySelector(itensLineId)
            let itensText = document.querySelector(itensTextId)

            itensLine.classList.remove("activeCard");
            itensText.classList.remove("active");
        });
    });

    showStep(currentStep);

    form.addEventListener("submit", function (e) {
        if (stepValidations[4]) {
            e.preventDefault();
            window.location.href = "/src/submit.html";
        } else {
            e.preventDefault()
            textError.classList.remove("hidden")
            textError.innerHTML = `Passo 5 não foi preenchido corretamente!`;
        }

    });
});

const cnpjInput = document.getElementById("cnpj");
cnpjInput.addEventListener("change", async function () {
    const cnpj = cnpjInput.value;
    stepValidations[0] = await verificaCNPJ(cnpj);
});

const cepjInput = document.getElementById("cep");
const numero = document.getElementById("numero");
const dadosCep = [cepjInput, numero]
dadosCep.forEach(dado => dado.addEventListener("change", async function () {
    stepValidations[1] = await verificaCEP(cepjInput.value, numero.value)
}));


const element = document.querySelector("[data-mask]");
element.addEventListener("change", async function () {
    const numero = element.value;

    const loadInput = () => {
        maskInput(element, element.dataset.mask);
        if (numero.length > 10) {
            stepValidations[2] = true
        } else {
            stepValidations[2] = false
        }
    };
    loadInput();
});

const nomeInput = document.getElementById("nome");
const usernameInput = document.getElementById("username");
const emailInput = document.getElementById("email");

const dadosUser = [nomeInput, usernameInput, emailInput]
dadosUser.forEach(dado => dado.addEventListener("change", async function () {
    const campo = dado.id;
    stepValidations[3] = await verificaCamposDoFormulario(campo);
}));


const senhaInput = document.getElementById("senha");
const confirmaSenhaInput = document.getElementById("confirma-senha");
const senhaUser = [senhaInput, confirmaSenhaInput]
senhaUser.forEach(dado => dado.addEventListener("input", async function () {
    const campo = dado.id;
    stepValidations[4] = await verificaSenha(campo);
}));
