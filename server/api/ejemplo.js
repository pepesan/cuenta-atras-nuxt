export default defineEventHandler(() => {

    let minutos = 10;
    let segundos = 0;

    // Definimos un color basado en el tiempo restante
    let color = 'rgb(191, 56, 58)';
    return {
        minutos,
        segundos,
        color
    };
})

