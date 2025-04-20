<template>
  <div class="flex items-center justify-center min-h-screen">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <p class="formato text-center text-4xl font-mono" :style="{ color: colorFondo }">
        {{ minutosFormateados }}:{{ segundosFormateados }}
      </p>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'

const minutos = ref(0)
const segundos = ref(0)
const colorFondo = ref('white')

const minutosFormateados = computed(() => minutos.value.toString().padStart(2, '0'))
const segundosFormateados = computed(() => segundos.value.toString().padStart(2, '0'))

let intervalo

const cargarCuentaAtras = async () => {
  try {
    const respuesta = await $fetch('/api/contador')
    minutos.value = respuesta.minutos
    segundos.value = respuesta.segundos
    colorFondo.value = respuesta.color
    iniciarContador()
  } catch (error) {
    console.error('Error cargando la cuenta atrás:', error)
  }
}

const iniciarContador = () => {
  intervalo = setInterval(() => {
    if (segundos.value > 0) {
      segundos.value--
    } else if (minutos.value > 0) {
      minutos.value--
      segundos.value = 59
    } else {
      clearInterval(intervalo)
    }
  }, 1000)
}

onMounted(() => {
  cargarCuentaAtras()
})

onUnmounted(() => {
  clearInterval(intervalo)
})
</script>

<style scoped>
.formato{
  display: flex;
  justify-content: center; /* Centra horizontalmente */
  align-items: center;     /* Centra verticalmente */
  height: 100vh;           /* Altura del contenedor: 100% del viewport */
  font-size: 160px;         /* Tamaño de fuente */
  margin: 0;               /* Elimina márgenes por defecto */
  font-family: 'Roboto', sans-serif; /* Aquí aplicas la fuente */
}
</style>
