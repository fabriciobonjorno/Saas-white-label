import Toastify from "toastify-js";

document.addEventListener('turbo:load', () => {
  const backgroundColors = {
    alert: "#f39c12",
    error: "#f44336",
    notice: "#009688"
  }
  JSON.parse(document.body.dataset.flashMessages).forEach(flashMessage => {
    const [type, message] = flashMessage;
    Toastify(
      {
        text: message,
        duration: 3000,
        close: true,
        style: {
          background: backgroundColors[type],
        },
        stopOnFocus: true
      }
    ).showToast();
  });
});