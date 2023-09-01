export function createAlert() {
    let overlay = document.createElement("div");
    overlay.id = "overlay";
    overlay.className = "fixed inset-0 bg-black opacity-50 z-50";
    overlay.style.display = "none"; 

    let customAlert = document.createElement("div");
    customAlert.id = "customAlert";
    customAlert.className = "fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-white p-4 shadow-lg rounded z-50";
    customAlert.style.display = "none"; 

    let alertContent = document.createElement("p");
    alertContent.id = "nameAlert"
    alertContent.textContent = "Esta é uma mensagem de alerta personalizada.";

    let closeButton = document.createElement("button");
    closeButton.id = "fecharAlerta";
    closeButton.className = "bg-green-500 hoverClick text-white font-bold py-2 px-4 mt-2 rounded";
    closeButton.textContent = "Fechar";

    customAlert.appendChild(alertContent);
    customAlert.appendChild(closeButton);

    document.body.appendChild(overlay);
    document.body.appendChild(customAlert);

    closeButton.addEventListener("click", function() {
        toggleAlert(false);
    });
}

export function toggleAlert(open, text) {
    let overlay = document.getElementById("overlay");
    let customAlert = document.getElementById("customAlert");
    let nameAlert = document.getElementById("nameAlert");

    if (open) {
        overlay.style.display = "block";
        customAlert.style.display = "block";
        nameAlert.innerHTML = text
    } else {
        overlay.style.display = "none";
        customAlert.style.display = "none";
    }
}